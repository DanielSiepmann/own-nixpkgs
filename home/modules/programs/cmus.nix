{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.cmus;

  desktopItem = pkgs.writeTextDir "share/applications/cmus.desktop"
    (generators.toINI { } {
      "Desktop Entry" = {
        Type = "Application";
        Exec = "${cfg.package}/bin/cmus";
        Terminal = true;
        Name = "C* Music Player";
        Comment = "A small, fast and powerful console music player";
        GenericName = "Music player";
        Categories = "ConsoleOnly;Audio;Player";
        Keywords = "cmus;audio;player";
      };
    });

in {
  options.programs.cmus = {
    enable = mkEnableOption "Cmus";

    package = mkOption {
      type = types.package;
      default = pkgs.cmus;
      defaultText = literalExpression "pkgs.cmus";
      description = "Cmus package to install.";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = optional cfg.enable (hiPrio desktopItem);
    };
  };
}
