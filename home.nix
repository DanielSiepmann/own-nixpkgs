{ config, pkgs, ... }:

{

  imports = [
    ./home/modules/programs/cmus.nix
    ./home/modules/programs/languagetool.nix
    ./home/modules/programs/mailhog.nix
  ];

  home = {

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "daniels";
    homeDirectory = "/home/daniels";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";

    packages = import ./home/packages.nix {
      inherit pkgs;
    };

    file = import ./home/files.nix { };

  } // import ./home/home.nix {
    inherit pkgs;
  };

  targets.genericLinux.enable = true;

  nix = import ./home/programs/nix.nix {
    inherit pkgs;
  };

  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    neovim = import ./home/programs/neovim.nix {
      inherit pkgs;
    };
    git = import ./home/programs/git.nix {
      inherit pkgs;
    };
    htop = import ./home/programs/htop.nix {
      inherit config;
    };
    tmux = import ./home/programs/tmux.nix {
      inherit pkgs;
    };
    jq = import ./home/programs/jq.nix {
      inherit config;
    };
    zsh = import ./home/programs/zsh.nix {
      inherit config pkgs;
    };

    firefox = import ./home/programs/firefox.nix {
      inherit pkgs;
    };

    # Media
    cmus.enable = true;

  };

  fonts.fontconfig.enable = true;

  xsession = import ./home/xsession.nix {
    inherit config pkgs;
  };

  xdg = import ./home/xdg.nix {
    inherit pkgs;
  };

  gtk = import ./home/gtk.nix {
    inherit pkgs;
  };

  services = {
    dunst = import ./home/services/dunst.nix;
    mailhog.enable = true;
    languagetool.enable = true;
    nextcloud-client.enable = true;
  };

  systemd.user = import ./home/systemd.nix {
    inherit config pkgs;
  };

}
