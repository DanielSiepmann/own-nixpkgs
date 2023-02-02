{ pkgs, lib, ... }:

# TODO: Find way to place typo3-configuration at expected path.

{
  imports = [
    ./web-development/daniel-siepmann.localhost.nix
  ];

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
}