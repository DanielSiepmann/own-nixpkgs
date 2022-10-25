{ config, pkgs }:

let

  sqlformat = pkgs.callPackage ./packages/sqlformat {
  };

in {
  # Let Home Manager install and manage itself.
  home-manager.enable = true;

  neovim = import ./programs/neovim.nix {
    inherit pkgs sqlformat;
  };

  git = import ./programs/git.nix {
    inherit pkgs;
  };

  htop = import ./programs/htop.nix {
    inherit config;
  };

  tmux = import ./programs/tmux.nix {
    inherit pkgs;
  };

  jq = import ./programs/jq.nix {
    inherit config;
  };

  zsh = import ./programs/zsh.nix {
    inherit config pkgs;
  };

  keychain = import ./programs/keychain.nix {
    inherit config pkgs;
  };

  gpg = import ./programs/gpg.nix {
    inherit config;
  };

  ssh = import ./programs/ssh.nix {
  };

  zathura = import ./programs/zathura.nix {
  };

  firefox = import ./programs/firefox.nix {
    inherit pkgs;
  };

  vdirsyncer = import ./programs/vdirsyncer.nix {
    inherit config pkgs;
  };
  khal = import ./programs/khal.nix {
    inherit config;
  };

  # Media
  cmus.enable = true;

  offlineimap.enable = true;
  neomutt = {
    enable = true;
    vimKeys = true;
    sidebar = {
      enable = true;
    };
  };
}
