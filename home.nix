{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "daniels";
  home.homeDirectory = "/home/daniels";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.nix
    pkgs.cacert

    # System tools
    pkgs.dmenu
    pkgs.st
    pkgs.dunst
    pkgs.i3lock-color

    # System monitoring
    pkgs.htop

    # Dev tools
    pkgs.litecli
    pkgs.mycli
    pkgs.mkcert
    pkgs.tig
    pkgs.universal-ctags

    # Writing
    pkgs.languagetool

    # Media
    pkgs.vlc
  ];

  programs = {
    git = import ./home/programs/git.nix {
      inherit pkgs;
    };
  };

  home.file = {
    ".myclirc".source = ./home/files/myclirc;
    ".config/ctags/config".source = ./home/files/ctags;
  };

  services.dunst = import ./home/configurations/dunst.nix;

  systemd.user.services.languagetool = import ./home/services/languagetool.nix {
    settings = {
      port = "8081";
      allow-origin = "*";
    };
    inherit pkgs;
  };
}
