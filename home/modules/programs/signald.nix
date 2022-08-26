{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.signald;
in {
  options.programs.signald = {
    enable = mkEnableOption "signald";

    package = mkOption {
      type = types.package;
      default = pkgs.signald;
      description = "signald package to install.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.signald = {
      Unit = {
        Description = "A  daemon for interacting with the Signal Private Messenger";
        Wants = "network.target";
        After = "network.target";
      };

      Service = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/signald";
        Restart = "on-failure";
        SuccessExitStatus = "143";
      };

      Install = {
        WantedBy = [ "multi-user.target" ];
      };
    };
  };
}
