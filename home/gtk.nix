{ pkgs }:

# Possible alternatives:
# https://github.com/FedoraQt/adwaita-qt
# https://github.com/EliverLara/Nordic
# And maybe use https://github.com/themix-project/oomox to adjust the color to follow my color scheme

{
  enable = true;

  theme = {
    package = pkgs.qogir-theme;
    name = "Qogir-Ubuntu-Dark";
  };

  iconTheme = {
    package = pkgs.qogir-icon-theme;
    name = "Qogir-ubuntu-dark";
  };

  font = {
    package = pkgs.roboto-mono;
    name = "Roboto Mono";
    size = 14;
  };

  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-enable-animations = 0;
  };

  gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-enable-animations = 0;
  };

}
