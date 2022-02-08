self: super:

let
  tmux = "${super.pkgs.tmux}/bin/tmux";
  mycli = "${super.pkgs.mycli}/bin/mycli";
  sed = "${super.pkgs.gnused}/bin/sed";
  source = ''
    #!${super.pkgs.bash}/bin/bash

    # This script will create a new tmux session (or attach existing)

    # TODO/NOTE: mysql is still coming from Ubuntu system, same goes for nvim and docker-compose
    # TODO/NOTE: Does not yet start nix shells, something for future once I figured it out.

    # Initialize some variables
    domain="$(echo $1 | ${sed} 's/\./-/g')"
    session="project-$domain"
    projectName="$(pwd)/$1"
    projectRoot="$(pwd)/$1"
    url="https://$domain.$(basename $(pwd) | ${sed} 's/\-//g').localhost/"
    editorPath="$projectRoot"
    additionalConfiguration="/home/daniels/.dotfiles/configs/php/typo3/AdditionalConfiguration.inc.php"

    # Only create session if not already exists
    ${tmux} has-session -t "$session"
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
        testingDatabaseName="$(echo $databaseName)_testing"

        if ! mysql -u admin "$databaseName" -e exit > /dev/null 2>&1 ; then
            databaseName=
            testingDatabaseName=
        fi
        if ! mysql -u admin "$testingDatabaseName" -e exit > /dev/null 2>&1 ; then
            testingDatabaseName=
        fi
        if [ "$testingDatabaseName" == "" ]; then
            testingDatabaseName="testing"
        fi

        editorPath="$projectRoot"
        if [ -d "$projectRoot/project" ]; then
            editorPath="$projectRoot/project"
        elif [ -d "$projectRoot/htdocs" ]; then
            editorPath="$projectRoot/htdocs"
        fi

        # Open Editor
        ${tmux} new-session -s "$session" -n editor -d
        ${tmux} send-keys " export TYPO3_BASE=$url TYPO3_COMPOSER_AUTOLOAD=1 TYPO3_ADDITIONAL_CONFIGURATION=$additionalConfiguration SOLR_HOST=localhost SOLR_PORT=8983 SOLR_SCHEME=http SOLR_CORE=core_de" C-m
        if [ "$testingDatabaseName" != "" ]; then
            ${tmux} send-keys " export typo3DatabaseName=$testingDatabaseName typo3DatabaseHost=localhost typo3DatabaseUsername=testing typo3DatabasePassword=testing" C-m
        fi
        ${tmux} send-keys " renice -n 5 \$\$" C-m
        ${tmux} send-keys " cd $editorPath" C-m
        # I guess I don't need that?! The editor doesn't use the database
        if [ "$databaseName" != "" ]; then
            ${tmux} send-keys " export TYPO3_DATABASE=$databaseName" C-m
        fi
        ${tmux} send-keys C-l
        ${tmux} send-keys " nvim" C-m
        let "windowId+=1"

        # Open Shell
        ${tmux} new-window -n project -t "$session"
        ${tmux} send-keys -t "$session:$windowId" "cd $editorPath" C-m
        ${tmux} send-keys " renice -n 5 \$\$" C-m
        ${tmux} send-keys " export TYPO3_BASE=$url TYPO3_COMPOSER_AUTOLOAD=1 TYPO3_ADDITIONAL_CONFIGURATION=$additionalConfiguration SOLR_HOST=localhost SOLR_PORT=8983 SOLR_SCHEME=http SOLR_CORE=core_de" C-m
        ${tmux} send-keys C-l
        if [ "$testingDatabaseName" != "" ]; then
            ${tmux} send-keys " export typo3DatabaseName=$testingDatabaseName typo3DatabaseHost=localhost typo3DatabaseUsername=testing typo3DatabasePassword=testing" C-m
            ${tmux} send-keys C-l
        fi
        if [ "$databaseName" != "" ]; then
            ${tmux} send-keys " export TYPO3_DATABASE=$databaseName" C-m
            ${tmux} send-keys C-l
        else
            ${tmux} send-keys " export TYPO3_DATABASE="
        fi
        let "windowId+=1"

        # Open "data" folder
        # if [ -d "$projectRoot/data" ]; then
        #     ${tmux} split-window
        #     ${tmux} send-keys " cd $projectRoot/data" C-m
        #     ${tmux} send-keys C-l
        # fi

        ${tmux} select-pane -t 0

        # Connect to MySQL
        if [ "$databaseName" != "" ] || [ "$testingDatabaseName" != "" ]; then
            ${tmux} new-window -n database -t "$session"
            ${tmux} send-keys -t "$session:$windowId" "cd $editorPath" C-m
            ${tmux} send-keys " renice -n 5 \$\$" C-m

            if [ "$databaseName" != "" ]; then
                ${tmux} send-keys " ${mycli} -u admin -D $databaseName" C-m
            else
                ${tmux} send-keys " ${mycli} -u admin -D "
            fi
            ${tmux} send-keys C-l

            if [ "$testingDatabaseName" != "" ]; then
                ${tmux} split-window
                ${tmux} send-keys " cd $editorPath" C-m
                ${tmux} send-keys " renice -n 5 \$\$" C-m
                ${tmux} send-keys " ${mycli} -u admin -D $testingDatabaseName" C-m
                ${tmux} send-keys C-l
            fi

            ${tmux} select-pane -t 0
            let "windowId+=1"
        fi

        # Open export folder
        # This step is specific to one customer
        if [ -d "$projectRoot/project/typo3export/files/export-edit/" ]; then
            ${tmux} new-window -n export -t "$session"
            ${tmux} send-keys -t "$session:$windowId" "cd $projectRoot/project/typo3export/files/export-edit/" C-m
            ${tmux} send-keys C-l

            let "windowId+=1"
        fi

        # TODO: Build dynamically, check each folder for docker-compose.yml and execute?!
        # Or at least define array of folder names to check

        # Start solr docker container
        if [ -d "$projectRoot/solr/" ]; then
            solrPath="$projectRoot/solr/"

            ${tmux} new-window -n docker -t "$session"
            ${tmux} send-keys -t "$session:$windowId" "cd $solrPath" C-m
            ${tmux} send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need solr running to do our job.
            ${tmux} send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports solr"

            let "windowId+=1"
        fi
        # Start elastic container
        if [ -d "$projectRoot/elastic/" ]; then
            elasticPath="$projectRoot/elastic/"

            ${tmux} new-window -n docker -t "$session"
            ${tmux} send-keys -t "$session:$windowId" "cd $elasticPath" C-m
            ${tmux} send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need elastic running to do our job.
            ${tmux} send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports elastic"

            let "windowId+=1"
        fi
        # Start mysql docker container
        if [ -d "$projectRoot/mysql/" ]; then
            mysqlPath="$projectRoot/mysql/"
            ${tmux} split-window
            ${tmux} send-keys "cd $mysqlPath" C-m
            ${tmux} send-keys C-l
            ${tmux} send-keys "docker-compose run --rm mysql" C-m
        fi
        # Start mongodb container
        if [ -d "$projectRoot/mongodb/" ]; then
            mongodbPath="$projectRoot/mongodb/"

            ${tmux} new-window -n docker -t "$session"
            ${tmux} send-keys -t "$session:$windowId" "cd $mongodbPath" C-m
            ${tmux} send-keys C-l
            # Missing C-m at end, because we don't want to submit.
            # We often don't need mongodb running to do our job.
            ${tmux} send-keys -t "$session:$windowId" "docker-compose run --rm --service-ports mongodb"

            let "windowId+=1"
        fi

        # Activate shell
        ${tmux} select-window -t 1
    fi
    # Attach to existing or created session
    ${tmux} attach -t "$session"
  '';
in {
  custom-customer-project = super.stdenv.mkDerivation {
    name = "custom-customer-project";

    src = source;

    dontUnpack = true;

    installPhase = ''
      mkdir -p "$out/bin"
      printf "%s" "$src" > "$out/bin/customerProject"
      chmod ug+x $out/bin/customerProject
    '';
  };
}
