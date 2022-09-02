{ config, pkgs, lib, ... }:

{

  imports = [
    ./home/modules/programs/cmus.nix
    ./home/modules/programs/languagetool.nix
    ./home/modules/programs/mailhog.nix
    ./home/modules/programs/signald.nix
    ./home/modules/programs/my-pidgin.nix
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

  programs = import ./home/programs.nix {
    inherit config pkgs;
  };

  fonts.fontconfig.enable = true;

  xsession = import ./home/xsession.nix {
    inherit config pkgs;
  };

  xdg = import ./home/xdg.nix {
    inherit pkgs;
  };

  dconf = import ./home/dconf.nix {
    inherit lib;
  };

  qt = import ./home/qt.nix {
    inherit pkgs;
  };
  gtk = import ./home/gtk.nix {
    inherit pkgs;
  };

  services = import ./home/services.nix {
    inherit config;
  };

  systemd.user = import ./home/systemd.nix {
    inherit config pkgs;
  };

}
