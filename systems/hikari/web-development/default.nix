{ pkgs, config, lib, ... }:

let

  mysqlEnsurePermissionsForDevUser = builtins.listToAttrs (
    map (databaseName: {
      name = "${databaseName}.*";
      value = "ALL PRIVILEGES";
    })
    config.custom.web-development.databases
  );

in {
  imports = [

    ./lib/mkcert.nix

    ./projects/private.nix
    ./projects/service-wrapper.nix
    ./projects/typo3.nix
    ./projects/customer.nix

  ];

  options = {

    custom.web-development = {
      rootPath = lib.mkOption {
        type = lib.types.path;
        default = "/var/projects";
        description = ''
          The root folder where web development happens.
          All Projects need to be placed within this folder.
        '';
      };
      databases = lib.mkOption {
        type = lib.types.listOf lib.types.string;
        default = [];
        example = lib.literalExpression "[namespace_project namespace2_project1]";
        description = ''
          A list of all necessary databases.
          Used to create the databases and grant permissions.
        '';
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
            # alter user dev@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('dev');
            name = "dev";
            ensurePermissions = mysqlEnsurePermissionsForDevUser;
          }
        ];

        ensureDatabases = [
          "testing" # Used by TYPO3 functional tests
          "testing_at" # Used by TYPO3 Acceptance tests
        ] ++ config.custom.web-development.databases;

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
      # TODO: Improve handling of TYPO3 global configuration
      # Current issue: The files are copied once.
      # Changes are not reflected until reboot?
      # I can edit the copied files, but need to keep files in sync.
      "C ${config.custom.web-development.rootPath}/own/typo3-configuration - - - - ${config.users.users.daniels.home}/.config/nixpkgs/home/files/typo3-configuration"
    ];

  };
}
