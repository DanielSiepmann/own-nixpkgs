{ config, pkgs }:

# Possible alternatives:
# https://github.com/FedoraQt/adwaita-qt
# https://github.com/EliverLara/Nordic
# And maybe use https://github.com/themix-project/oomox to adjust the color to follow my color scheme

{
  enable = true;

  theme = {
    package = pkgs.qogir-theme;
    name = "Qogir-Dark";
  };

  iconTheme = {
    package = pkgs.qogir-icon-theme;
    name = "Qogir-dark";
  };

  font = {
    package = pkgs.roboto-mono;
    name = "Roboto Mono";
    size = 14;
  };

  gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-enable-animations = 0;
  };

  gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-enable-animations = 0;
  };

}
