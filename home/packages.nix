{ pkgs, ownLib }:

with pkgs; [
  nix
  cacert
  nvd

  # System tools
  dmenu
  gnome.gnome-screenshot
  acpilight # Used to support xbacklight on hikari

  networkmanager_dmenu
  # TODO: Create one `./packages/custom/default.nix which includes all other?
  (callPackage ./packages/custom/dmenu-scripts { })
  (callPackage ./packages/custom/update-system { })
  (callPackage ./packages/custom/update-nixos-system { })
  (callPackage ./packages/custom/update-ubuntu-system { })
  (callPackage ./packages/custom/push-etckeeper { })
  (callPackage ./packages/custom/backup { })
  (callPackage ./packages/custom/nextcloud-sync/from-local.nix { })
  (callPackage ./packages/custom/nextcloud-sync/from-remote.nix { })
  (callPackage ./packages/custom/typo3-documentation-rendering {
    inherit ownLib;
  })
  (callPackage ./packages/custom/build-phpactor { })
  i3blocks
  st
  ncdu
  tree
  (callPackage ./packages/rst2pdf { })
  (callPackage ./packages/sitediff { })

  borgbackup
  keepassxc
  # Git itself is installed via git module
  git-crypt
  git-remote-hg

  rclone

  libreoffice

  # Dev tools
  litecli
  sqlite
  mycli
  sc-im
  # mytop
  mkcert # TODO: Create own wrapper script to create new certs
  tig
  universal-ctags
  silver-searcher
  curl
  wget
  kcachegrind
  geckodriver
  podman
  podman-compose

  # In order to pull binaries from their.
  # E.g. phps: https://github.com/fossar/nix-phps#how-to-use
  cachix

  # Coding / Neovim
  # Does not provide any autocompletion yet, don't know why
  # Use in conjuncion with https://github.com/autozimu/LanguageClient-neovim
  # rnix-lsp

  (callPackage ./packages/custom/project {
    inherit ownLib;
  })

  # Communication
  signal-desktop
  thunderbird

  # Media
  vlc
  handbrake
  # Typical download looks like: yt-dlp -S 'res:700,ext:mp4' <url>
  yt-dlp
  spotdl
  # Does not work for some reason, need installed via apt
  # sound-juicer
  # tenacity
  ffmpeg
  python39Packages.mutagen
  feh

  gtk-engine-murrine
]
