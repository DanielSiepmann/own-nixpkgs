{ pkgs }:

{
  enable = true;

  configFile = {

    "i3blocks/config".source = ./files/i3-blocks;

    "borg/exclude".source = ./files/borg-exclude;
    "ctags/config.ctags".source = ./files/ctags;
    "sc-im/scimrc".source = ./files/scimrc;
    "ncdu/config".source = ./files/ncdu;
    "keepassxc/keepassxc.ini".text = pkgs.lib.generators.toINI { } {

      General = {
        ConfigVersion = 2;
      };

      FdoSecrets = {
        Enabled = true;
        ShowNotification = false;
      };

      GUI = {
        ApplicationTheme = "dark";
        CompactMode = true;

        HidePreviewPanel = false;
        HideToolbar = true;
        HideUsernames = false;

        MinimizeToTray = true;
        ShowTrayIcon = true;
        TrayIconAppearance = "monochrome-light";

      };

      PasswordGenerator = {
        AdditionalChars = "";
        AdvancedMode = true;
        Braces = true;
        Dashes = true;
        ExcludedChars = "*<>!?";
        Length = 16;
        Math = true;
        Quotes = true;
        SpecialChars = false;
      };

      Browser = {
        CustomProxyLocation = "";
        Enabled = true;
        SearchInAllDatabases = true;
      };

      Security = {
        ClearSearchTimeout = 120;
        LockDatabaseIdle = true;
        LockDatabaseIdleSeconds = 120;
        Security_HideNotes = true;
      };

    };
    "litecli/config".source = ./files/litecli;
    "phpactor".source = ./files/phpactor;
    "tig/config".source = ./files/tig;
    "yamllint/config".source = ./files/yamllint/config;

    # Music player
    "cmus/rc".source = ./files/cmus/rc;
    "cmus/smyckblue.theme".source = ./files/cmus/smyckblue.theme;

    "networkmanager-dmenu/config.ini".text = pkgs.lib.generators.toINI { } {
      dmenu = {
        dmenu_command = "dmenu -i -l 25";
      };
    };

    "composer/update-channel".text = "stable";
    "composer/auth.json".source = ./files/composer/auth.json;

    "rclone/rclone.conf".source = ./files/rclone.conf;

    "nvim/syntax/php.vim".source = ./files/nvim/syntax/php.vim;

    "docker/config.json".source = ./files/docker/config.json;

  };

  dataFile = {
    "xsd/xliff-core-1.2-strict.xsd".source = pkgs.fetchurl {
      url = "https://docs.oasis-open.org/xliff/v1.2/os/xliff-core-1.2-strict.xsd";
      sha256 = "nzevVk7NJ9X2kVTXz+e6jesfYgyBuUzw6rH0IFx01fg=";
    };
    "typo3-configuration".source = ./files/typo3-configuration;
  };

  desktopEntries = {
    toggl = {
      name = "Toggl Time Tracking";
      type = "Application";
      exec = "firefox --new-instance -P toggl --class=\"time-tracking\" https://track.toggl.com/timer";
    };
    mailhog-ui = {
      name = "Mailhog";
      type = "Application";
      exec = "firefox --new-instance -P mailhog --class=\"mailhog\" https://mailhog.localhost";
    };
    microsoft-teams = {
      name = "Microsoft Teams";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --app=https://teams.microsoft.com/ --user-agent=\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36\"";
    };
    slack = {
      name = "Slack";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --app=https://slack.com/";
    };
    phone = {
      name = "Phone (Sipgate)";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"phone\" --new-window --app=https://app.sipgate.com/w3/phone/phone";
    };
  };

  mime.enable = true;
  mimeApps = {
    enable = true;
    # Use file --mime-type <filename> to detect mime type
    defaultApplications = {

      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

      "text/calendar" = [ "org.kde.korganizer.desktop" ];

      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];

      # Images
      "image/bmp" = [ "feh.desktop" ];
      "image/gif" = [ "feh.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/jpg" = [ "feh.desktop" ];
      "image/pjpeg" = [ "feh.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/tiff" = [ "feh.desktop" ];
      "image/webp" = [ "feh.desktop" ];
      "image/x-bmp" = [ "feh.desktop" ];
      "image/x-pcx" = [ "feh.desktop" ];
      "image/x-png" = [ "feh.desktop" ];
      "image/x-portable-anymap" = [ "feh.desktop" ];
      "image/x-portable-bitmap" = [ "feh.desktop" ];
      "image/x-portable-graymap" = [ "feh.desktop" ];
      "image/x-portable-pixmap" = [ "feh.desktop" ];
      "image/x-tga" = [ "feh.desktop" ];
      "image/x-xbitmap" = [ "feh.desktop" ];

      # Video
      "video/mp4" = [ "vlc.desktop" ];
      "video/m4v" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
    };
  };

}
