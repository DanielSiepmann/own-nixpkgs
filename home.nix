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

  nix = import ./home/programs/nix.nix {
    inherit pkgs;
  };

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
    pkgs.custom-update-system
    pkgs.dunst
    pkgs.st
    pkgs.ncdu
    pkgs.tree
    pkgs.rst2pdf

    pkgs.espeak
    pkgs.bc

    pkgs.borgbackup
    pkgs.keepassxc

    pkgs.libreoffice

    # Dev tools
    pkgs.litecli
    pkgs.sqlite
    pkgs.mycli
    # pkgs.mytop
    pkgs.robo3t
    pkgs.mkcert
    pkgs.tig
    pkgs.universal-ctags
    pkgs.silver-searcher
    pkgs.curl
    pkgs.wget
    pkgs.yamllint
    pkgs.kcachegrind
    pkgs.geckodriver

    # In order to pull binaries from their.
    # E.g. phps: https://github.com/fossar/nix-phps#how-to-use
    pkgs.cachix

    # Coding / Neovim
    # Does not provide any autocompletion yet, don't know why
    # Use in conjuncion with https://github.com/autozimu/LanguageClient-neovim
    # pkgs.rnix-lsp

    pkgs.custom-customer-project

    # Communication
    pkgs.signal-desktop
    pkgs.thunderbird

    # Media
    pkgs.vlc
    pkgs.yt-dlp
    # Does not work for some reason, need installed via apt
    # pkgs.sound-juicer
    # pkgs.audacity
    pkgs.ffmpeg
    pkgs.python39Packages.mutagen
  ];

  programs = {
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

  home.file = {
    ".profile".source = ./home/files/profile;
    ".myclirc".source = ./home/files/myclirc;
    ".agignore".source = ./home/files/agignore;
  };

  xdg.configFile = {
    "ctags/config.ctags".source = ./home/files/ctags;
    "litecli/config".source = ./home/files/litecli;
    "phpactor".source = ./home/files/phpactor;
    "tig/config".source = ./home/files/tig;

    "cmus/smyckblue.theme".source = ./home/files/cmus/smyckblue.theme;
    "cmus/rc".source = ./home/files/cmus/rc;

    "i3/config".source = ./home/files/i3;
    "i3blocks/config".source = ./home/files/i3-blocks;

    "borg/exclude".source = ./home/files/borg-exclude;
  };

  xdg.dataFile = {
    "xsd/xliff-core-1.2-strict.xsd".source = pkgs.fetchurl {
      url = "https://docs.oasis-open.org/xliff/v1.2/os/xliff-core-1.2-strict.xsd";
      sha256 = "nzevVk7NJ9X2kVTXz+e6jesfYgyBuUzw6rH0IFx01fg=";
    };
  };

  xdg.desktopEntries = {
    networkmanager-dmenu = {
      type = "Application";
      exec = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
      name = "Networkmanager dmenu";
      comment = "Networkmanaging using dmenu";
      genericName = "Networkmanager Setting";
      categories = [
        "Network"
      ];
    };
    slack-typo3 = {
      name = "Slack TYPO3";
      type = "Application";
      exec = "/snap/bin/chromium --class=\"chat\" --new-window --app=https://app.slack.com/client/T024TUMLZ/unreads";
    };
    slack-codappix = {
      name = "Slack Codappix";
      type = "Application";
      exec = "/snap/bin/chromium --class=\"chat\" --new-window --app=https://app.slack.com/client/T2DPNS55W/unreads";
    };
    slack-sac = {
      name = "Slack SAC";
      type = "Application";
      exec = "/snap/bin/chromium --class=\"chat\" --new-window --app=https://app.slack.com/client/T3FANTPL5/unreads";
    };
    microsoft-teams = {
      name = "Microsoft Teams";
      type = "Application";
      exec = "/snap/bin/chromium --class=\"chat\" --new-window --user-agent=\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36\" --new-window --app=https://teams.microsoft.com/";
    };
    mattermost = {
      name = "Mattermost werkraum-media";
      type = "Application";
      exec = "/snap/bin/chromium --class=\"chat\" --new-window --new-window --app=https://mattermost.werkraum-media.de/";
    };
    werkraum-jitsi = {
      name = "Jitsi werkraum-media";
      type = "Application";
      exec = "/snap/bin/chromium --class=\"chat\" --new-window --new-window --app=https://jitsi.werkraum-media.de/codappix";
    };
    toggl = {
      name = "Toggl Time Tracking";
      type = "Application";
      exec = "${pkgs.firefox}/bin/firefox --class=\"time-tracking\" --new-instance -P toggl https://track.toggl.com/timer";
    };
    mailhog-ui = {
      name = "Mailhog";
      type = "Application";
      exec = "${pkgs.firefox}/bin/firefox --class=\"mailhog\" --new-instance -P mailhog https://mailhog.localhost";
    };
  };

  services.dunst = import ./home/services/dunst.nix;
  services.mailhog.enable = true;
  services.languagetool.enable = true;

  services.nextcloud-client.enable = true;
  # Temporary fix to OpenGL issue by using GLX.
  # Start nextcloud without GLX support which is fine for me for noe.
  # I don't have a better way for now, then using `pkgs.lib.mkForce` and setting whole value (repeating from modules/services/nextcloud-client.nix).
  systemd.user.services.nextcloud-client.Service.Environment = pkgs.lib.mkForce [
    "PATH=${config.home.profileDirectory}/bin"
    "QT_XCB_GL_INTEGRATION=none"
  ];
}
