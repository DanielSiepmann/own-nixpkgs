{ config }:

{
  enable = true;

  iconTheme = {
    package = config.gtk.iconTheme.package;
    name = "${config.gtk.iconTheme.name}";
    size = "32";
  };

  settings = {
    global = {
      monitor = 0;
      follow = "none";

      width = 1000000;
      height = 300;
      origin = "top-left";
      offset = "0x0";
      scale = 0;
      corner_radius = 0;

      notification_limit = 0;
      progress_bar = true;

      indicate_hidden = "yes";

      transparency = 0;

      separator_height = 2;
      separator_color = "frame";

      padding = 8;
      horizontal_padding = 8;
      text_icon_padding = 0;

      frame_width = 1;
      frame_color = "#72B3CC";

      sort = "yes";

      idle_threshold = 120;

      font = "Monospace 14";
      line_height = 0;
      markup = "full";
      format = "<b>%s</b>\\n%b\\n(%a)";
      alignment = "left";
      vertical_alignment = "center";
      show_age_threshold = 60;
      ellipsize = "middle";
      ignore_newline = "no";

      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = "yes";

      icon_position = "left";
      min_icon_size = 0;
      max_icon_size = 32;

      sticky_history = "yes";
      history_length = 20;
    };

    # Define format of different urgencies
    urgency_low = {
      background = "#000000";
      foreground = "#72B3CC";
      timeout = 10;
    };
    urgency_normal = {
      background = "#000000";
      foreground = "#72B3CC";
      timeout = 10;
    };
    urgency_critical = {
      background = "#000000";
      foreground = "#E09690";
      timeout = 30;
    };

    # Define explicit rules
    # Prefix with rule- to mark them as rule for myself.
    # Prefix x- is necessary to sort them after urgency_ defaults in generated ini file.
    # All sections are sorted alphabetical, done would come before urgency and would be overwritten again.
    x-rule-networkmanager = {
      appname = "NetworkManager";
      urgency = "low";
      new_icon = "network-wireless";
      timeout = 2;
    };
    x-rule-james = {
      summary = "*James Greenwood*";
      foreground = "#E09690";
      urgency = "critical";
      timeout = 30;
      format = "<b>%s</b>(%a)";
    };
    x-rule-reute-export = {
      summary = "TYPO3 Export";
      foreground = "#8EB33B";
      timeout = 30;
    };
    x-rule-switching = {
      summary = "switching*";
      foreground = "#8EB33B";
      timeout = 3;
    };
    x-rule-done = {
      summary = "*done*";
      foreground = "#8EB33B";
      timeout = 60;
    };
  };
}
