{ pkgs }:

with pkgs; [
  nix
  cacert
  nvd

  # System tools
  dmenu

  networkmanager_dmenu
  (callPackage ./packages/custom/dmenu-scripts { })
  (callPackage ./packages/custom/update-system { })
  (callPackage ./packages/custom/update-ubuntu-system { })
  (callPackage ./packages/custom/push-etckeeper { })
  (callPackage ./packages/custom/backup { })
  dunst
  i3blocks
  st
  ncdu
  tree
  (callPackage ./packages/rst2pdf { })
  (callPackage ./packages/sitediff { })
  numlockx

  espeak
  bc

  borgbackup
  git-crypt
  git-remote-hg
  keepassxc

  libreoffice

  # Dev tools
  litecli
  sqlite
  mycli
  sc-im
  # mytop
  robo3t
  mkcert
  tig
  universal-ctags
  silver-searcher
  curl
  wget
  kcachegrind
  geckodriver

  # In order to pull binaries from their.
  # E.g. phps: https://github.com/fossar/nix-phps#how-to-use
  cachix

  # Coding / Neovim
  # Does not provide any autocompletion yet, don't know why
  # Use in conjuncion with https://github.com/autozimu/LanguageClient-neovim
  # rnix-lsp

  (callPackage ./packages/custom/customer-project { })

  # Communication
  thunderbird
  evolution

  # Media
  vlc
  yt-dlp
  spotdl
  # Does not work for some reason, need installed via apt
  # sound-juicer
  # audacity
  ffmpeg
  python39Packages.mutagen
  darktable
  feh
]
