{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.vdirsyncer;
in {
  options.programs.vdirsyncer = {
    enable = mkEnableOption "vdirsyncer";

    package = mkOption {
      type = types.package;
      default = pkgs.vdirsyncer;
      description = "vdirsyncer package to install.";
    };

    frequency = mkOption {
      type = types.str;
      default = "*:0/15";
      example = "hourly";
      description = ''
          The sync frequency.
          Check <literal>man systemd.time</literal> for more information on the syntax.
      '';
    };

    configuration = mkOption {
      type = types.str;
      default = "";
      description = ''
          The content of the configuration file.
          See:
          - https://vdirsyncer.pimutils.org/en/stable/tutorial.html#configuration
          - https://github.com/pimutils/vdirsyncer/blob/main/config.example
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."vdirsyncer/config".text = cfg.configuration;

    systemd.user.services.vdirsyncer = {
      Unit = { Description = "vdirsyncer synchronisation"; };
      Service = { ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync"; };
    };

    systemd.user.timers.vdirsyncer = {
      Unit = { Description = "vdirsyncer synchronisation"; };
      Timer = {
        OnBootSec = "15min";
        OnCalendar = "${cfg.frequency}";
        Persistent = true;
        Unit = "vdirsyncer.service";
      };
      Install = { WantedBy = [ "timers.target" ]; };
    };
  };
}
