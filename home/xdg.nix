{ pkgs }:

{
  enable = true;

  configFile = {

    "i3blocks/config".source = ./files/i3-blocks;

    "borg/exclude".source = ./files/borg-exclude;
    "ctags/config.ctags".source = ./files/ctags;
    "keepassxc/keepassxc.ini".text = pkgs.lib.generators.toINI { } {
      General = {
        ConfigVersion = 2;
      };
      GUI = {
        ApplicationTheme = "dark";
        CompactMode = true;
        HidePreviewPanel = false;
        HideToolbar = true;
        HideUsernames = false;
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
    };
    "litecli/config".source = ./files/litecli;
    "phpactor".source = ./files/phpactor;
    "tig/config".source = ./files/tig;
    "yamllint/config".source = ./files/yamllint/config;

    # Music player
    "cmus/rc".source = ./files/cmus/rc;
    "cmus/smyckblue.theme".source = ./files/cmus/smyckblue.theme;

  };

  dataFile = {
    "xsd/xliff-core-1.2-strict.xsd".source = pkgs.fetchurl {
      url = "https://docs.oasis-open.org/xliff/v1.2/os/xliff-core-1.2-strict.xsd";
      sha256 = "nzevVk7NJ9X2kVTXz+e6jesfYgyBuUzw6rH0IFx01fg=";
    };
    "typo3-configuration".source = ./files/typo3-configuration;
  };

  desktopEntries = {
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
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --app=https://app.slack.com/client/T024TUMLZ/unreads";
    };
    slack-codappix = {
      name = "Slack Codappix";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --app=https://app.slack.com/client/T2DPNS55W/unreads";
    };
    slack-sac = {
      name = "Slack SAC";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --app=https://app.slack.com/client/T3FANTPL5/unreads";
    };
    microsoft-teams = {
      name = "Microsoft Teams";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --user-agent=\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36\" --new-window --app=https://teams.microsoft.com/";
    };
    mattermost = {
      name = "Mattermost werkraum-media";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --new-window --app=https://mattermost.werkraum-media.de/";
    };
    werkraum-jitsi = {
      name = "Jitsi werkraum-media";
      type = "Application";
      exec = "${pkgs.chromium}/bin/chromium --class=\"chat\" --new-window --new-window --app=https://jitsi.werkraum-media.de/codappix";
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

  mime.enable = true;
  mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
    };
  };

}
