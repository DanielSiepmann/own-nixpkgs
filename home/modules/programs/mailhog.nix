{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.mailhog;

  args = lib.concatStringsSep " " (
    [
      "-api-bind-addr 127.0.0.1:${toString cfg.apiPort}"
      "-smtp-bind-addr 127.0.0.1:${toString cfg.smtpPort}"
      "-ui-bind-addr 127.0.0.1:${toString cfg.uiPort}"
      "-storage ${cfg.storage}"
    ] ++ lib.optional (cfg.storage == "maildir")
      "-maildir-path $STATE_DIRECTORY"
    ++ cfg.extraArgs
  );

in
{
  options.services.mailhog = {
    enable = mkEnableOption "MailHog";

    storage = mkOption {
      type = types.enum [ "maildir" "memory" ];
      default = "memory";
      description = "Store mails on disk or in memory.";
    };

    apiPort = mkOption {
      type = types.port;
      default = 8025;
      description = "Port on which the API endpoint will listen.";
    };

    smtpPort = mkOption {
      type = types.port;
      default = 1025;
      description = "Port on which the SMTP endpoint will listen.";
    };

    uiPort = mkOption {
      type = types.port;
      default = 8025;
      description = "Port on which the HTTP UI will listen.";
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of additional arguments to pass to the MailHog process.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.mailhog = {
      Unit = {
        Description = "MailHog - Web and API based SMTP testing";
      };

      Service = {
        Restart = "on-failure";
        ExecStart = "${pkgs.mailhog}/bin/MailHog ${args}";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
