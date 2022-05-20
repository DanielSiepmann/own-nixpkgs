{ pkgs }:

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

  cursorTheme = {
    package = pkgs.qogir-icon-theme;
    name = "Qogir-ubuntu-dark";
    size = 16;
  };

  font = {
    package = pkgs.roboto-mono;
    name = "Roboto Mono";
    size = 14;
  };

  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };

  gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };

}
