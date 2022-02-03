{ config, pkgs, ... }:

{
  imports = [
    ./home/modules/programs/cmus.nix
    ./home/modules/programs/languagetool.nix
  ];

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

  # Install packages
  # Some are installed via `programs` below, as they are also configured.
  # Some packages don't have a module for configuration, and are configured via `home.file` below.
  home.packages = [
    pkgs.nix
    pkgs.cacert

    # System tools
    pkgs.dmenu
    pkgs.dunst
    pkgs.st

    # Dev tools
    pkgs.litecli
    pkgs.mycli
    pkgs.robo3t
    pkgs.mkcert
    pkgs.tig
    pkgs.universal-ctags
    pkgs.silver-searcher

    # Media
    pkgs.vlc
  ];

  programs = {
    git = import ./home/programs/git.nix {
      inherit pkgs;
    };
    htop = import ./home/programs/htop.nix {
      inherit config;
    };
    tmux = import ./home/programs/tmux.nix {
    };

    # Media
    cmus.enable = true;
  };

  home.file = {
    ".myclirc".source = ./home/files/myclirc;
    ".config/ctags/config".source = ./home/files/ctags;
    ".agignore".source = ./home/files/agignore;
  };

  services.dunst = import ./home/services/dunst.nix;
  services.languagetool.enable = true;
}
