{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.khal;

  # See: https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs
  # See: https://github.com/NixOS/nixpkgs/issues/205014
  workingKhalPkgs = import (builtins.fetchTarball {
    name = "nixpkgs-working-khal";
    url = "https://github.com/nixos/nixpkgs/archive/54582ac93fa8a1784bc8a2009a6cc6efe5a9106f.tar.gz";
    sha256 = "1ggfbg44xw8zwlwimgl04di5c9h9rfm27c80w9qjq378sr5sr8ly";
  }) {};

  notificationScript = pkgs.writeShellApplication {
    name = "khal-notification";
    text = ''
      date=$(date "+%H:%M:00")
      events=$(${workingKhalPkgs.khal}/bin/khal list --notstarted "$date" "$1")
      if [ -z "$events" ]; then
        exit 0;
      fi

      ${pkgs.libnotify}/bin/notify-send \
        --urgency=critical \
        --expire-time=90000 \
        --icon="${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}/32/apps/office-calendar.svg" \
        --category="x-custom.calendar.event" \
        "Upcoming Events" \
        "$events"
      exit 0
    '';
  };

in {
  options.programs.khal = {
    enable = mkEnableOption "khal";

    package = mkOption {
      type = types.package;
      default = workingKhalPkgs.khal;
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
