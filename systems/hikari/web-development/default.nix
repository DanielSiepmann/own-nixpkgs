{ pkgs, config, lib, ... }:

{
  imports = [
    ./mkcert.nix

    ./mailhog.localhost.nix

    ./daniel-siepmann.localhost.nix
  ];

  options = {
    custom.web-development = {
      rootPath = lib.mkOption {
        type = lib.types.path;
        default = "/var/projects";
      };
    };
  };

  config = {

    services = {
      httpd = {
        enable = true;

        user = "daniels";

        adminAddr = "apache@hikari.localhost";

        extraModules = [
          "info"
          "rewrite"
          "proxy"
          "proxy_fcgi"
        ];

        virtualHosts."localhost".locations."/server-info" = {
          extraConfig = ''
            SetHandler server-info
            Require local
          '';
        };
      };

      mysql = {
        enable = true;

        package = pkgs.mariadb;

        ensureUsers = [
          {
            name = "daniels";
            ensurePermissions = {
              "*.*" = "ALL PRIVILEGES";
            };
          }
          {
            # INITIALLY once change dev user to be identified by password
            name = "dev";
            ensurePermissions = {
              # TODO: Auto build from defined databases?!
              "own_danielsiepmann.*" = "ALL PRIVILEGES";
            };
          }
        ];

        ensureDatabases = [
          "testing" # Used by TYPO3 functional tests
          "testing_at" # Used by TYPO3 Acceptance tests
        ];

        settings = {
          mysqld = {
            # sql_mode = "SRTICT_TRANS_TABLES;NO_ZERO_IN_DATE;NO_ZERO_DATE;ERROR_FOR_DIVISION_BY_ZERO;NO_ENGINE_SUBSTITUTION";
            general_log = true;
            general_log_file = "/var/lib/mysql/query.log";

            bind-address = "127.0.0.1";
            # = "/var/log/mysql/query.log";
          };
        };
      };
    };

    systemd.tmpfiles.rules = [
      # Would be cool to improve this somehow.
      # Current issues: The link is created once against nix store.
      # Changes are not reflected until reboot?
      "C ${config.custom.web-development.rootPath}/own/typo3-configuration - - - - ${config.users.users.daniels.home}/.local/share/typo3-configuration"
    ];
  };
}
