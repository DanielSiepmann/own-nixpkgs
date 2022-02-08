{ config, pkgs, ... }:

{
  imports = [
    ./home/modules/programs/cmus.nix
    ./home/modules/programs/languagetool.nix
    ./home/modules/programs/mailhog.nix
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
    pkgs.networkmanager_dmenu
    pkgs.dmenu-custom-scripts
    pkgs.dunst
    pkgs.st
    pkgs.ncdu
    pkgs.tree

    # Dev tools
    pkgs.litecli
    pkgs.mycli
    pkgs.robo3t
    pkgs.mkcert
    pkgs.tig
    pkgs.universal-ctags
    pkgs.silver-searcher
    pkgs.jq
    pkgs.curl

    pkgs.custom-customer-project

    # Communication
    pkgs.signal-desktop
    pkgs.mattermost-desktop

    # Media
    pkgs.vlc
    pkgs.yt-dlp
    pkgs.sound-juicer
    pkgs.audacity
    pkgs.ffmpeg
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
    zsh = import ./home/programs/zsh.nix {
      inherit config;
      inherit pkgs;
    };

    # Media
    cmus.enable = true;
  };

  home.file = {
    ".myclirc".source = ./home/files/myclirc;
    ".agignore".source = ./home/files/agignore;
  };

  xdg.configFile = {
    "ctags/config".source = ./home/files/ctags;
    "litecli/config".source = ./home/files/litecli;
    "phpactor/phpactor.yml".source = ./home/files/phpactor.yml;
    "tig/config".source = ./home/files/tig;

    "nix/nix.conf".source = ./home/files/nix.conf;

    "cmus/smyckblue.theme".source = ./home/files/cmus/smyckblue.theme;
    "cmus/rc".source = ./home/files/cmus/rc;

    "i3/config".source = ./home/files/i3;
    "i3blocks/config".source = ./home/files/i3-blocks;
  };

  xdg.desktopEntries.networkmanager-dmenu = {
    type = "Application";
    exec = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
    name = "Networkmanager dmenu";
    comment = "Networkmanaging using dmenu";
    genericName = "Networkmanager Setting";
    categories = [
      "Network"
    ];
  };

  services.dunst = import ./home/services/dunst.nix;
  services.mailhog.enable = true;
  services.languagetool.enable = true;
}
