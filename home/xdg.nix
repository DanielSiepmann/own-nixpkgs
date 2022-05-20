{ pkgs }:

{
  enable = true;

  configFile = {
    "ctags/config.ctags".source = ./files/ctags;
    "litecli/config".source = ./files/litecli;
    "phpactor".source = ./files/phpactor;
    "yamllint/config".source = ./files/yamllint/config;
    "tig/config".source = ./files/tig;

    "cmus/smyckblue.theme".source = ./files/cmus/smyckblue.theme;
    "cmus/rc".source = ./files/cmus/rc;

    "i3blocks/config".source = ./files/i3-blocks;

    "borg/exclude".source = ./files/borg-exclude;
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

  mime.enable = true;

  mimeApps = {
    enable = true;
    defaultApplications = {
      "application/octet-stream" = [ "vlc.desktop" ];
      "application/x-sql" = [ "nvim.desktop" ];
      "text/calendar" = [ "thunderbird.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "video/mp4" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "video/webm" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
    };
  };

}
