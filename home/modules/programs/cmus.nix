{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.cmus;
in {
  options.programs.cmus = {
    enable = mkEnableOption "Cmus";

    package = mkOption {
      type = types.package;
      default = pkgs.cmus;
      description = "Cmus package to install.";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = optional cfg.enable cfg.package;
    };
    xdg.desktopEntries.cmus = {
      type = "Application";
      exec = "${cfg.package}/bin/cmus";
      terminal = true;
      name = "C* Music Player";
      comment = "A small, fast and powerful console music player";
      genericName = "Music player";
      categories = [
        "Audio"
        "AudioVideo"
        "ConsoleOnly"
      ];
    };
  };
}
