{
  writeShellApplication,
  bash,
  gnused,
  ownLib
}:

let

  positionOfCustomerName = if ownLib.onHikari {} then "5" else "7";
  mysqlUser = if ownLib.onHikari {} then "-u daniels" else "";

in writeShellApplication {
  name = "custom-project";

  runtimeInputs = [
    bash
    gnused
  ];

  text = ''
    #!bash/bin/bash
    # This script will create a new tmux session (or attach existing)
    # NOTE: Does not start nix shells, as this would maybe download stuff, I start them on my own on demand.

    session="project-''${1/\./-/}"
    # Only create session if not already exists
    if ! tmux has-session -t "$session"; then
        windowId=0

        projectName="$1"
        customerName="$(pwd | cut -d'/' -f ${positionOfCustomerName})"
        projectRoot="$(pwd)/$projectName"
        editorPath="$projectRoot"
        databaseName="''${customerName}_''${projectName}"
        databaseName=''${databaseName//-/}
        url="https://$projectName.$customerName.localhost/"

        editorPath="$projectRoot"
        if [ -d "$projectRoot/project" ]; then
            editorPath="$projectRoot/project"
        elif [ -d "$projectRoot/htdocs" ]; then
            editorPath="$projectRoot/htdocs"
        fi

        # Start new session
        # with editor as name for first window
        # and set environment
        tmux new-session \
          -s "$session" \
          -n editor \
          -d \
          -e TYPO3_BASE="$url" \
          -e TYPO3_COMPOSER_AUTOLOAD=1 \
          -e typo3DatabaseName=testing \
          -e typo3DatabaseHost=localhost \
          -e typo3DatabaseUsername=testing \
          -e typo3DatabasePassword=testing \
          -e TYPO3_DATABASE="$databaseName" \
          -e INSTANCE_PATH="$editorPath/typo3temp/var/tests/acceptance" \
          -e SOLR_HOST=localhost \
          -e SOLR_PORT=8983 \
          -e SOLR_SCHEME=http \
          -e SOLR_CORE=core_de

        # Open Editor
        tmux send-keys " renice -n 5 \$\$" C-m
        tmux send-keys " cd $editorPath" C-m
        tmux send-keys C-l
        tmux send-keys " nvim" C-m
        (( "windowId+=1" ))

        # Open Shell
        tmux new-window -n project -t "$session"
        tmux send-keys -t "$session:$windowId" "cd $editorPath" C-m
        tmux send-keys " renice -n 5 \$\$" C-m
        tmux send-keys C-l
        (( "windowId+=1" ))
        tmux select-pane -t 0

        # Connect to database
        tmux new-window -n database -t "$session"
        tmux send-keys -t "$session:$windowId" "cd $editorPath" C-m
        tmux send-keys " renice -n 5 \$\$" C-m
        tmux send-keys "mycli ${mysqlUser} -D "
        if [ "$databaseName" != "" ]; then
            tmux send-keys "$databaseName" C-m
        fi
        tmux send-keys C-l
        (( "windowId+=1" ))

        # Open export folder
        # This step is specific to one customer
        if [ -d "$projectRoot/typo3export/files/export-edit/" ]; then
            tmux new-window -n export -t "$session"
            tmux send-keys -t "$session:$windowId" "cd $projectRoot/typo3export/files/export-edit/" C-m
            tmux send-keys C-l

            (( "windowId+=1" ))
        fi

        # TODO: Build dynamically, check each folder for docker-compose.yml and execute?!
        # Or at least define array of folder names to check

        # Start solr docker container
        if [ -d "$projectRoot/solr/" ]; then
            solrPath="$projectRoot/solr/"

            tmux new-window -n docker -t "$session"
            tmux send-keys -t "$session:$windowId" "cd $solrPath" C-m
            tmux send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need solr running to do our job.
            tmux send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports solr"

            (( "windowId+=1" ))
        fi
        # Start oracle proxy docker container
        if [ -d "$projectRoot/oraproxy/" ]; then
            oraproxyPath="$projectRoot/oraproxy/"

            tmux new-window -n docker -t "$session"
            tmux send-keys -t "$session:$windowId" "cd $oraproxyPath" C-m
            tmux send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need oraproxy running to do our job.
            tmux send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports oraproxy"

             (( "windowId+=1" ))
        fi
        # Start elastic container
        if [ -d "$projectRoot/elastic/" ]; then
            elasticPath="$projectRoot/elastic/"

            tmux new-window -n docker -t "$session"
            tmux send-keys -t "$session:$windowId" "cd $elasticPath" C-m
            tmux send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need elastic running to do our job.
            tmux send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports elastic"

            (( "windowId+=1" ))
        fi
        # Start mongodb container
        if [ -d "$projectRoot/mongodb/" ]; then
            mongodbPath="$projectRoot/mongodb/"

            tmux new-window -n docker -t "$session"
            tmux send-keys -t "$session:$windowId" "cd $mongodbPath" C-m
            tmux send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need mongodb running to do our job.
            tmux send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports mongodb"

            (( "windowId+=1" ))
        fi

        # Activate shell
        tmux select-window -t 1
    fi
    # Attach to existing or created session
    tmux attach -t "$session"
  '';
}
