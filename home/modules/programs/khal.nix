{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.khal;

  # TODO: Make more compatible, e.g. provide notify from outside and add checks whether to use or not.
  # Maybe create small php script instead which parses the khal output and checks for beginning
  notificationScript = pkgs.writeShellApplication {
    name = "khal-notification";
    text = ''
      date=$(date "+%H:%M:00")
      events=$(${pkgs.khal}/bin/khal list --notstarted "$date" "$1")
      if [ -z "$events" ]; then
        exit 0;
      fi

      notify-send -u critical "Upcoming Events" "$events"
      exit 0
    '';
  };

in {
  options.programs.khal = {
    enable = mkEnableOption "khal";

    package = mkOption {
      type = types.package;
      default = pkgs.khal;
      description = "khal package to install.";
    };

    frequency = mkOption {
      type = types.str;
      default = "*:0/15";
      example = "hourly";
      description = ''
          The notification frequency.
          Check <literal>man systemd.time</literal> for more information on the syntax.
      '';
    };

    time_delta = mkOption {
      type = types.str;
      default = "15m";
      example = "15m";
      description = "The delta to pass to khal list.";
    };

    configuration = mkOption {
      type = types.str;
      default = "";
      description = ''
          The content of the configuration file.
          See: https://lostpackets.de/khal/configure.html
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."khal/config".text = cfg.configuration;

    systemd.user.services.khal_notification = {
      Unit = { Description = "khal notification"; };
      Service = { ExecStart = "${notificationScript}/bin/khal-notification \"${cfg.time_delta}\""; };
    };

    systemd.user.timers.khal_notification = {
      Unit = { Description = "khal notification"; };
      Timer = {
        OnCalendar = "${cfg.frequency}";
        Unit = "khal_notification.service";
      };
      Install = { WantedBy = [ "timers.target" ]; };
    };
  };
}
