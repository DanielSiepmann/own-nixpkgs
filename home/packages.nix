{ pkgs }:

with pkgs; [
  nix
  cacert
  nvd

  # System tools
  dmenu
  networkmanager_dmenu
  dmenu-custom-scripts
  custom-update-system
  custom-push-etckeeper
  custom-backup
  dunst
  i3blocks
  st
  ncdu
  tree
  rst2pdf

  espeak
  bc

  borgbackup
  git-crypt
  keepassxc

  libreoffice

  # Dev tools
  litecli
  sqlite
  mycli
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

  custom-customer-project

  # Communication
  signal-desktop
  thunderbird

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
