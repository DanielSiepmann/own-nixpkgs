{ config, pkgs }:

{
  # Let Home Manager install and manage itself.
  home-manager.enable = true;

  # Add hook to zsh and bash.
  # Does not work as there is no sqlite file.
  # command-not-found.enable = true;
  # Use nix-index as replacement.
  # This needs to build index, which I do in custom-update-system
  nix-index.enable = true;

  neovim = import ./programs/neovim.nix {
    inherit pkgs;
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

  zathura = import ./programs/zathura.nix {
  };

  firefox = import ./programs/firefox.nix {
    inherit pkgs;
  };

  mcfly = import ./programs/mcfly.nix {
  };

  # Media
  cmus.enable = true;
}
