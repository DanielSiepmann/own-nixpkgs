{ config, pkgs }:

{
  services = {
    batteryicon = import ./services/batteryicon.nix {
      inherit pkgs;
    };
  };

  tmpfiles.rules = [
    "L ${config.xdg.dataHome}/themes - - - - ${config.home.profileDirectory}/share/themes"
    "L ${config.xdg.dataHome}/icons/${config.gtk.iconTheme.name} - - - - ${config.home.profileDirectory}/share/icons/${config.gtk.iconTheme.name}"
  ];
}
