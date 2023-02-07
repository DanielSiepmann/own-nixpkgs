{
  config
  , lib
  , pkgs
  , domain
  , relativeDocumentRoot
  , databaseName
  , phpPackage
}:

let
  documentRoot = "${config.custom.web-development.rootPath}/${relativeDocumentRoot}";
in {
  services = {

    httpd.virtualHosts.${domain} = {
      forceSSL = true;
      sslServerCert = "${config.custom.web-development.certFolder}${domain}.pem";
      sslServerKey = "${config.custom.web-development.certFolder}${domain}-key.pem";

      inherit documentRoot;

      extraConfig = ''
        <Directory ${documentRoot}>
            AllowOverride None
            Require all granted
            DirectoryIndex index.php

            RewriteEngine On

            # Store the current location in an environment variable CWD to use
            # mod_rewrite in .htaccess files without knowing the RewriteBase
            RewriteCond $0#%{REQUEST_URI} ([^#]*)#(.*)\1$
            RewriteRule ^.*$ - [E=CWD:%2]

            # Rule for versioned static files, configured through:
            # - $GLOBALS['TYPO3_CONF_VARS']['BE']['versionNumberInFilename']
            # - $GLOBALS['TYPO3_CONF_VARS']['FE']['versionNumberInFilename']
            # IMPORTANT: This rule has to be the very first RewriteCond in order to work!
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteCond %{REQUEST_FILENAME} !-d
            RewriteRule ^(.+)\.(\d+)\.(php|js|css|png|jpg|gif|gzip)$ %{ENV:CWD}$1.$3 [L]

            # Access block for folders
            RewriteRule _(?:recycler|temp)_/ - [F]
            RewriteRule fileadmin/templates/.*\.(?:txt|ts)$ - [F]
            RewriteRule ^(?:vendor|typo3_src|typo3temp/var) - [F]
            RewriteRule (?:typo3conf/ext|typo3/sysext|typo3/ext)/[^/]+/(?:Configuration|Resources/Private|Tests?|Documentation|docs?)/ - [F]

            # Block access to all hidden files and directories with the exception of
            # the visible content from within the `/.well-known/` hidden directory (RFC 5785).
            RewriteCond %{REQUEST_URI} "!(^|/)\.well-known/([^./]+./?)+$" [NC]
            RewriteCond %{SCRIPT_FILENAME} -d [OR]
            RewriteCond %{SCRIPT_FILENAME} -f
            RewriteRule (?:^|/)\. - [F]

            # Stop rewrite processing, if we are in any other known directory
            # NOTE: Add your additional local storages here
            RewriteRule ^(?:fileadmin/|typo3conf/|typo3temp/|uploads/) - [L]

            # If the file/symlink/directory does not exist but is below /typo3/, redirect to the TYPO3 Backend entry point.
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteCond %{REQUEST_FILENAME} !-d
            RewriteCond %{REQUEST_FILENAME} !-l
            RewriteCond %{REQUEST_URI} ^/typo3/.*$
            RewriteRule ^typo3/(.*)$ %{ENV:CWD}typo3/index.php [QSA,L]

            # If the file/symlink/directory does not exist => Redirect to index.php.
            # For httpd.conf, you need to prefix each '%{REQUEST_FILENAME}' with '%{DOCUMENT_ROOT}'.
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteCond %{REQUEST_FILENAME} !-d
            RewriteCond %{REQUEST_FILENAME} !-l
            RewriteRule ^.*$ %{ENV:CWD}index.php [QSA,L]
        </Directory>

        <FilesMatch "\.php$">
            SetHandler  "proxy:unix:${config.services.phpfpm.pools."${domain}".socket}|fcgi://${domain}/"
        </FilesMatch>
      '';
    };

    phpfpm.pools.${domain} = {
      inherit (config.services.httpd) user group;
      inherit phpPackage;
      settings = {
        "listen.owner" = config.services.httpd.user;
        "listen.group" = config.services.httpd.group;
        "pm" = "ondemand";
        "pm.max_children" = 15;
        "php_admin_value[max_execution_time]" = 240;
        "php_admin_value[max_input_vars]" = 1500;
      };
      phpEnv = {
        TYPO3_ADDITIONAL_CONFIGURATION = "/var/projects/own/typo3-configuration/AdditionalConfiguration.inc.php";
        TYPO3_DATABASE = databaseName;
        TYPO3_CONTEXT = "Development/dsiepmann";
        IMAGEMAGICK_PATH = lib.makeBinPath [ pkgs.imagemagick ] + "/";
      };
    };

    mysql.ensureDatabases = [databaseName];

  };
}
