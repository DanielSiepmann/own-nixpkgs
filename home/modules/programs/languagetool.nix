{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.languagetool;

in {
  options.services.languagetool = {
    enable = mkEnableOption "languagetool";

    package = mkOption {
      type = types.package;
      default = pkgs.languagetool;
      defaultText = literalExpression "pkgs.languagetool";
      description = "languagetool package to install.";
    };

    port = mkOption {
      type = types.port;
      default = 8081;
      description = "Port to listen to.";
    };

    allow-origin = mkOption {
      type = types.str;
      default = "*";
      description = "allow-origin option, e.g. which domains to allow.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.languagetool = {
      Unit = {
        Description = "Languagetool Server";
        StartLimitBurst = 5;
        StartLimitIntervalSec = 30;
      };

      Service = {
        Restart = "on-failure";
        RestartSec = "1s";
        Environment = "JAVA_TOOL_OPTIONS=-Xmx256m";
        ExecStart = "${cfg.package}/bin/languagetool-http-server --port ${toString cfg.port} --allow-origin '${cfg.allow-origin}'";
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
