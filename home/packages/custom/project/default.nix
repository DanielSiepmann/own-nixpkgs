{
  writeShellApplication,
  bash,
  gnused
}:

writeShellApplication {
  name = "custom-project";

  runtimeInputs = [
    bash
    gnused
  ];

  text = ''
    #!bash/bin/bash
    # This script will create a new tmux session (or attach existing)
    # TODO/NOTE: Does not yet start nix shells, something for future once I figured it out.

    session="project-''${1/\./-/}"
    # Only create session if not already exists
    if ! tmux has-session -t "$session"; then
        windowId=0

        projectName="$1"
        customerName="$(pwd | cut -d'/' -f 7)"
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

        # Open Editor
        tmux new-session -s "$session" -n editor -d
        tmux send-keys "export TYPO3_BASE=$url TYPO3_COMPOSER_AUTOLOAD=1  SOLR_HOST=localhost SOLR_PORT=8983 SOLR_SCHEME=http SOLR_CORE=core_de" C-m
        tmux send-keys "export typo3DatabaseName=testing typo3DatabaseHost=localhost typo3DatabaseUsername=testing typo3DatabasePassword=testing" C-m
        # TODO: Find a better way to determine instance path for acceptance tests
        tmux send-keys "export INSTANCE_PATH=\"$editorPath/typo3temp/var/tests/acceptance\"" C-m
        tmux send-keys " renice -n 5 \$\$" C-m
        tmux send-keys " cd $editorPath" C-m
        tmux send-keys C-l
        tmux send-keys " nvim" C-m
        (( "windowId+=1" ))

        # Open Shell
        tmux new-window -n project -t "$session"
        tmux send-keys -t "$session:$windowId" "cd $editorPath" C-m
        tmux send-keys " renice -n 5 \$\$" C-m
        tmux send-keys "export TYPO3_BASE=$url TYPO3_COMPOSER_AUTOLOAD=1 SOLR_HOST=localhost SOLR_PORT=8983 SOLR_SCHEME=http SOLR_CORE=core_de" C-m
        tmux send-keys "export typo3DatabaseName=testing typo3DatabaseHost=localhost typo3DatabaseUsername=testing typo3DatabasePassword=testing" C-m
        tmux send-keys C-l
        if [ "$databaseName" != "" ]; then
            tmux send-keys "export TYPO3_DATABASE=$databaseName" C-m
            tmux send-keys C-l
        else
            tmux send-keys "export TYPO3_DATABASE="
        fi
        (( "windowId+=1" ))
        tmux select-pane -t 0

        # Connect to database
        tmux new-window -n database -t "$session"
        tmux send-keys -t "$session:$windowId" "cd $editorPath" C-m
        tmux send-keys " renice -n 5 \$\$" C-m
        if [ "$databaseName" != "" ]; then
            tmux send-keys "mycli -u admin -D $databaseName" C-m
        else
            tmux send-keys "mycli -u admin -D "
        fi
        tmux send-keys C-l
        tmux select-pane -t 0
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
