{
  stdenv,
  bash,
  gnused,
  mycli,
  tmux
}:

let
  tmuxBin = "${tmux}/bin/tmux";
  mycliBin = "${mycli}/bin/mycli";
  sedBin = "${gnused}/bin/sed";
  source = ''
    #!${bash}/bin/bash

    # This script will create a new tmux session (or attach existing)

    # TODO/NOTE: mysql is still coming from Ubuntu system, same goes for docker-compose
    # TODO/NOTE: Does not yet start nix shells, something for future once I figured it out.

    # Initialize some variables
    domain="$(echo $1 | ${sedBin} 's/\./-/g')"
    session="project-$domain"
    projectName="$(pwd)/$1"
    projectRoot="$(pwd)/$1"
    url="https://$domain.$(basename $(pwd) | ${sedBin} 's/\-//g').localhost/"
    editorPath="$projectRoot"

    # Only create session if not already exists
    ${tmuxBin} has-session -t "$session"
    if [ $? != 0 ]
    then
        windowId=0
        databaseName=$(basename $projectName)
        databaseName="$(basename $(dirname $projectName))_"$databaseName
        databaseName=''${databaseName//-/}

        # Support legacy variant with underscrore in db name
        if ! mysql -u admin "$databaseName" -e exit > /dev/null 2>&1 ; then
            databaseName=$(basename $projectName)
            # Replace - with _ for project name
            databaseName=''${databaseName//-/_}
            databaseName="$(basename $(dirname $projectName))_"$databaseName
            # Replace - with nothing for customer name, which was added right above
            databaseName=''${databaseName//-/}
        fi

        # Support legacy variant without customer prefix for now
        if ! mysql -u admin "$databaseName" -e exit > /dev/null 2>&1 ; then
            databaseName=$(basename $projectName)
            databaseName=''${databaseName//-/_}
        fi

        editorPath="$projectRoot"
        if [ -d "$projectRoot/project" ]; then
            editorPath="$projectRoot/project"
        elif [ -d "$projectRoot/htdocs" ]; then
            editorPath="$projectRoot/htdocs"
        fi

        # Open Editor
        ${tmuxBin} new-session -s "$session" -n editor -d
        ${tmuxBin} send-keys "export TYPO3_BASE=$url TYPO3_COMPOSER_AUTOLOAD=1  SOLR_HOST=localhost SOLR_PORT=8983 SOLR_SCHEME=http SOLR_CORE=core_de" C-m
        ${tmuxBin} send-keys "export typo3DatabaseName=testing typo3DatabaseHost=localhost typo3DatabaseUsername=testing typo3DatabasePassword=testing" C-m
        ${tmuxBin} send-keys " renice -n 5 \$\$" C-m
        ${tmuxBin} send-keys " cd $editorPath" C-m
        ${tmuxBin} send-keys C-l
        ${tmuxBin} send-keys " nvim" C-m
        let "windowId+=1"

        # Open Shell
        ${tmuxBin} new-window -n project -t "$session"
        ${tmuxBin} send-keys -t "$session:$windowId" "cd $editorPath" C-m
        ${tmuxBin} send-keys " renice -n 5 \$\$" C-m
        ${tmuxBin} send-keys "export TYPO3_BASE=$url TYPO3_COMPOSER_AUTOLOAD=1 SOLR_HOST=localhost SOLR_PORT=8983 SOLR_SCHEME=http SOLR_CORE=core_de" C-m
        ${tmuxBin} send-keys "export typo3DatabaseName=testing typo3DatabaseHost=localhost typo3DatabaseUsername=testing typo3DatabasePassword=testing" C-m
        ${tmuxBin} send-keys C-l
        if [ "$databaseName" != "" ]; then
            ${tmuxBin} send-keys "export TYPO3_DATABASE=$databaseName" C-m
            ${tmuxBin} send-keys C-l
        else
            ${tmuxBin} send-keys "export TYPO3_DATABASE="
        fi
        let "windowId+=1"
        ${tmuxBin} select-pane -t 0

        # Connect to database
        ${tmuxBin} new-window -n database -t "$session"
        ${tmuxBin} send-keys -t "$session:$windowId" "cd $editorPath" C-m
        ${tmuxBin} send-keys " renice -n 5 \$\$" C-m

        if [ "$databaseName" != "" ]; then
            ${tmuxBin} send-keys "${mycliBin} -u admin -D $databaseName" C-m
        else
            ${tmuxBin} send-keys "${mycliBin} -u admin -D "
        fi
        ${tmuxBin} send-keys C-l

        ${tmuxBin} select-pane -t 0
        let "windowId+=1"

        # Open export folder
        # This step is specific to one customer
        if [ -d "$projectRoot/project/typo3export/files/export-edit/" ]; then
            ${tmuxBin} new-window -n export -t "$session"
            ${tmuxBin} send-keys -t "$session:$windowId" "cd $projectRoot/project/typo3export/files/export-edit/" C-m
            ${tmuxBin} send-keys C-l

            let "windowId+=1"
        fi

        # TODO: Build dynamically, check each folder for docker-compose.yml and execute?!
        # Or at least define array of folder names to check

        # Start solr docker container
        if [ -d "$projectRoot/solr/" ]; then
            solrPath="$projectRoot/solr/"

            ${tmuxBin} new-window -n docker -t "$session"
            ${tmuxBin} send-keys -t "$session:$windowId" "cd $solrPath" C-m
            ${tmuxBin} send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need solr running to do our job.
            ${tmuxBin} send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports solr"

            let "windowId+=1"
        fi
        # Start oracle proxy docker container
        if [ -d "$projectRoot/oraproxy/" ]; then
            oraproxyPath="$projectRoot/oraproxy/"

            ${tmuxBin} new-window -n docker -t "$session"
            ${tmuxBin} send-keys -t "$session:$windowId" "cd $oraproxyPath" C-m
            ${tmuxBin} send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need oraproxy running to do our job.
            ${tmuxBin} send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports oraproxy"

            let "windowId+=1"
        fi
        # Start elastic container
        if [ -d "$projectRoot/elastic/" ]; then
            elasticPath="$projectRoot/elastic/"

            ${tmuxBin} new-window -n docker -t "$session"
            ${tmuxBin} send-keys -t "$session:$windowId" "cd $elasticPath" C-m
            ${tmuxBin} send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need elastic running to do our job.
            ${tmuxBin} send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports elastic"

            let "windowId+=1"
        fi
        # Start mysql docker container
        if [ -d "$projectRoot/mysql/" ]; then
            mysqlPath="$projectRoot/mysql/"
            ${tmuxBin} split-window
            ${tmuxBin} send-keys "cd $mysqlPath" C-m
            ${tmuxBin} send-keys C-l
            ${tmuxBin} send-keys "docker-compose run --rm mysql" C-m
        fi
        # Start mongodb container
        if [ -d "$projectRoot/mongodb/" ]; then
            mongodbPath="$projectRoot/mongodb/"

            ${tmuxBin} new-window -n docker -t "$session"
            ${tmuxBin} send-keys -t "$session:$windowId" "cd $mongodbPath" C-m
            ${tmuxBin} send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need mongodb running to do our job.
            ${tmuxBin} send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports mongodb"

            let "windowId+=1"
        fi

        # Activate shell
        ${tmuxBin} select-window -t 1
    fi
    # Attach to existing or created session
    ${tmuxBin} attach -t "$session"
  '';
in
stdenv.mkDerivation {
  name = "custom-customer-project";

  src = source;

  dontUnpack = true;

  installPhase = ''
    mkdir -p "$out/bin"
    printf "%s" "$src" > "$out/bin/customerProject"
    chmod ug+x $out/bin/customerProject
  '';
}
