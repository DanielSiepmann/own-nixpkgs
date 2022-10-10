{ config, pkgs }:

{
  services = {
    batteryicon = import ./services/batteryicon.nix {
      inherit pkgs;
    };
  };

  tmpfiles.rules = [
    "L ${config.home.homeDirectory}/.themes - - - - ${config.home.profileDirectory}/share/themes"
    "L ${config.home.homeDirectory}/.icons/${config.gtk.iconTheme.name} - - - - ${config.home.profileDirectory}/share/icons/${config.gtk.iconTheme.name}"
  ];
}
