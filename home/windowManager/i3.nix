{ config, pkgs }:

let
  modifier = config.xsession.windowManager.i3.config.modifier;
in {
  enable = true;
  config = {

    modifier = "Mod4";

    workspaceLayout = "tabbed";
    workspaceAutoBackAndForth = true;

    defaultWorkspace = "workspace 1";

    menu = "${pkgs.i3}/bin/i3-dmenu-desktop";

    fonts = {
      names = [ "monospace" ];
      style = "Bold";
      size = 12.0;
    };

    colors = {
      background = "#2E3436";
      focused = {
        border = "#000000";
        background = "#000000";
        text = "#72B3CC";
        indicator = "#72B3CC";
        childBorder = "#000000";
      };
      focusedInactive = {
        border = "#000000";
        background = "#000000";
        text = "#B0B0B0";
        indicator = "#5D5D5D";
        childBorder = "#000000";
      };
      unfocused = {
        border = "#000000";
        background = "#000000";
        text = "#B0B0B0";
        indicator = "#5D5D5D";
        childBorder = "#000000";
      };
      urgent = {
        border = "#72B3CC";
        background = "#72B3CC";
        text = "#FFFFFF";
        indicator = "#72B3CC";
        childBorder = "#72B3CC";
      };
      placeholder = {
        border = "#000000";
        background = "#000000";
        text = "#D3D7CF";
        indicator = "#000000";
        childBorder = "#000000";
      };
    };

    bars = [{
      mode = "hide";
      position = "top";

      workspaceButtons = true;
      workspaceNumbers = true;

      statusCommand = "${pkgs.i3blocks}/bin/i3blocks";

      fonts = {
        names = ["monospace"];
        style = "Bold";
        size = 12.0;
      };

      colors = {
        background = "#000000";
        statusline = "#72B3CC";
        separator = "#72B3CC";
        focusedWorkspace = {
          border = "#72B3CC";
          background = "#000000";
          text = "#72B3CC";
        };
        activeWorkspace = {
          border = "#000000";
          background = "#000000";
          text = "#72B3CC";
        };
        inactiveWorkspace = {
          border = "#000000";
          background = "#000000";
          text = "#72B3CC";
        };
        urgentWorkspace = {
          border = "#72B3CC";
          background = "#72B3CC";
          text = "#FFFFFF";
        };
        bindingMode = {
          border = "#72B3CC";
          background = "#72B3CC";
          text = "#FFFFFF";
        };
      };

      extraConfig = ''
        separator_symbol " "
      '';

    }];

    window = {
      titlebar = true;
      border = 0;
      hideEdgeBorders = "both";

      commands = [
        {
          command = ''title_format "<b>%title</b>"'';
          criteria = { class = ".*"; };
        }
        {
          command = "sticky enable";
          criteria = { window_type = "dialog"; };
        }
        {
          command = "sticky enable";
          criteria = { class = "KeePassXC"; };
        }
        {
          command = "border none";
          criteria = { class = "^vlc$"; };
        }
      ];
    };

    floating = {
      titlebar = true;
      border = 0;

      criteria = [
        { "class" = "KeePassXC"; }
      ];
    };

    assigns = {
      "2:💶" = [
        { class = "^time-tracking$"; }
        { class = "^mailhog$"; }
        # TODO: Check why this does not work anymore
        # { class = "^Firefox$"; }
      ];
      "3:💬" = [
        { class = "^chat$"; }
        { class = "^Signal$"; }
      ];
      "4:✉️" = [
        { class = "^Thunderbird$"; }
      ];
      "5:🎵" = [
        { class = "^vlc$"; }
        { class = "^Pavucontrol$"; }
        { class = "^Audacity$"; }
      ];
    };

    startup = [
      # TODO: Move configuration to configuration instead of calls from i3
      {
        # Increase mouse speed
        command = "xinput --set-prop 13 'libinput Accel Speed' 1";
        notification = false;
      }
      {
        # Use natural scrolling for trackpad
        command = "xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Natural Scrolling Enabled' 1";
        notification = false;
      }
      {
        command = "xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Tapping Enabled' 1";
        notification = false;
      }
      {
        # Use CAPS LOCK as ctrl
        command = "setxkbmap -option ctrl:nocaps; setxkbmap -option compose:ralt";
        notification = false;
        always = true;
      }
      {
        command = "xsetroot -solid \"#2E3436\"";
        notification = false;
      }
      {
        command = "xset s off";
        notification = false;
      }

      # Configure display
      {
        command = "xrandr --output eDP1 --scale 0.75x0.75 --mode 2560x1440 --brightness 1";
      }
      {
        command = "xbacklight -set 25";
      }

      # Start programs / applets
      {
        command = "clipit";
        notification = false;
      }
      {
        command = "eval $(ssh-agent)";
        notification = false;
      }
      {
        command = "nm-applet";
        notification = false;
      }
    ];

    keybindings = {
      # kill focused window
      "${modifier}+Shift+q" = "kill";

      # start a terminal
      "${modifier}+Return" = "exec st zsh";

      "${modifier}+Shift+a" = "exec xrandr --auto";

      # start dmenu (a program launcher)
      # "${modifier}+d" = "exec dmenu_run";
      # There also is the (new) i3-dmenu-desktop which only displays applications
      # shipping a .desktop file. It is a wrapper around dmenu, so you need that
      # installed.
      # For docs, see: https://developer.gnome.org/integration-guide/stable/desktop-files.html.en
      "${modifier}+a" = "exec --no-startup-id i3-dmenu-desktop";

      "${modifier}+space" = "exec --no-startup-id dmenu_selection";

      # change focus
      "${modifier}+h" = "focus left";
      "${modifier}+j" = "focus down";
      "${modifier}+k" = "focus up";
      "${modifier}+l" = "focus right";

      # move focused window
      "${modifier}+Shift+h" = "move left";
      "${modifier}+Shift+j" = "move down";
      "${modifier}+Shift+k" = "move up";
      "${modifier}+Shift+l" = "move right";

      # split in horizontal orientation
      "${modifier}+Right" = "split h";

      # split in vertical orientation
      "${modifier}+Down" = "split v";

      # enter fullscreen mode for the focused container
      "${modifier}+f" = "fullscreen toggle";

      # change container layout (stacked, tabbed, toggle split)
      "${modifier}+s" = "layout stacking";
      "${modifier}+t" = "layout tabbed";
      "${modifier}+e" = "layout toggle split";

      # toggle tiling / floating
      "${modifier}+Shift+f" = "floating toggle";

      # toggle sticky
      "${modifier}+Shift+s" = "sticky toggle";

      # switch to workspace
      "${modifier}+1" = "workspace 1";
      "${modifier}+2" = "workspace 2:💶";
      "${modifier}+3" = "workspace 3:💬";
      "${modifier}+4" = "workspace 4:✉️";
      "${modifier}+5" = "workspace 5:🎵";
      "${modifier}+6" = "workspace 6:T3";
      "${modifier}+7" = "workspace 7";
      "${modifier}+8" = "workspace 8";
      "${modifier}+9" = "workspace 9:🖥️";
      "${modifier}+0" = "workspace 10:🌐";

      # move focused container to workspace
      "${modifier}+Shift+1" = "move container to workspace 1";
      "${modifier}+Shift+2" = "move container to workspace 2:💶";
      "${modifier}+Shift+3" = "move container to workspace 3:💬";
      "${modifier}+Shift+4" = "move container to workspace 4:✉️";
      "${modifier}+Shift+5" = "move container to workspace 5:🎵";
      "${modifier}+Shift+6" = "move container to workspace 6:T3";
      "${modifier}+Shift+7" = "move container to workspace 7";
      "${modifier}+Shift+8" = "move container to workspace 8";
      "${modifier}+Shift+9" = "move container to workspace 9:🖥️";
      "${modifier}+Shift+0" = "move container to workspace 10:🌐";

      # workspace 9:🖥️  output DP2

      # Make the currently focused window a scratchpad
      "${modifier}+Shift+minus" = "move scratchpad";
      # Show the first scratchpad window
      "${modifier}+minus" = "scratchpad show";

      # reload the configuration file
      "${modifier}+Shift+c" = "reload";
      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      "${modifier}+Shift+r" = "restart";
      # exit i3 (logs you out of your X session)
      "${modifier}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'\"";

      # Move workspace between displays
      "${modifier}+Shift+Left" = "move workspace to output left";
      "${modifier}+Shift+Right" = "move workspace to output right";

      # Function Key Bindings (🎵)
      "XF86AudioPause" = "exec cmus-remote --pause";
      "XF86AudioPlay" = "exec cmus-remote --pause";
      "XF86AudioPrev" = "exec cmus-remote --prev";
      "XF86AudioNext" = "exec cmus-remote --next";
      "XF86AudioMute" = "exec \"amixer -D pulse sset Master 0\"";
      "XF86AudioRaiseVolume" = "exec \"amixer -D pulse sset Master 5%+\"";
      "XF86AudioLowerVolume" = "exec \"amixer -D pulse sset Master 5%-\"";

      # Switch sound device:
      # https://askubuntu.com/a/72076/491377
      #
      # Detect current devices
      # pulseaudio -k && pactl load-module module-detect
      #
      # Run Pulseaudio Volume Control and adjust
      # Adjust also "default / fallback" device, in order to make volume control work.
      #
      # Alternativly via cli:
      # ~ > pacmd list-sinks
      # ~ > pacmd list-sink-inputs
      # ~ > pacmd set-default-sink 8
      # ~ > pacmd move-sink-input 3 8

      # Function Key Bindings (💡)
      "XF86MonBrightnessUp" = "exec xbacklight -inc 10 && notify-send \"Changed Display Brightness\" \"Now: $(xbacklight)\"";
      "XF86MonBrightnessDown" = "exec xbacklight -dec 10 && notify-send \"Changed Display Brightness\" \"Now: $(xbacklight)\"";
      "Shift+XF86MonBrightnessUp" = "exec xbacklight -inc 1 && notify-send \"Changed Display Brightness\" \"Now: $(xbacklight)\"";
      "Shift+XF86MonBrightnessDown" = "exec xbacklight -dec 1 && notify-send \"Changed Display Brightness\" \"Now: $(xbacklight)\"";

      # Dunst Key Bindings
      # See: man dunstctl.1
      "Control+space" = "exec --no-startup-id dunstctl close-all";
      "Control+grave" = "exec --no-startup-id dunstctl history-pop";

      "${modifier}+d" = "mode displays";
      "${modifier}+r" = "mode resize";
    };

    modes = {
      resize = {
        "h" = "resize shrink width 10 px or 10 ppt";
        "j" = "resize grow height 10 px or 10 ppt";
        "k" = "resize shrink height 10 px or 10 ppt";
        "l" = "resize grow width 10 px or 10 ppt";
        "Shift+h" = "resize shrink width 50 px or 50 ppt";
        "Shift+j" = "resize grow height 50 px or 50 ppt";
        "Shift+k" = "resize shrink height 50 px or 50 ppt";
        "Shift+l" = "resize grow width 50 px or 50 ppt";

        # same bindings, but for the arrow keys
        "Left" = "resize shrink width 10 px or 10 ppt";
        "Down" = "resize grow height 10 px or 10 ppt";
        "Up" = "resize shrink height 10 px or 10 ppt";
        "Right" = "resize grow width 10 px or 10 ppt";

        # back to normal: Enter or Escape
        "Return" = "mode default";
        "Escape" = "mode default";
      };
      # TODO: Maybe move to dmenu script instead?!
      # "display setup: [a]uto [e]extern only [h]ome [i]intern [r]ecord [v]ideo" = {
      displays = {
        "a" = "exec xrandr --auto --output eDP1 --scale 1x1 --mode 1920x1080 && xbacklight -set 10;";
        "e" = "exec xrandr --auto --output eDP1 --off";
        "h" = "exec xrandr --output eDP1 --off --output DP2-1 --scale 1x1 --mode 2560x1440 && setxkbmap -option ctrl:nocaps && setxkbmap -option compose:ralt && setxkbmap -option numpad:mac";
        "v" = "exec xrandr --auto --output DP2-1 --primary --scale 1x1 --mode 2560x1440 --output eDP1 --mode 1920x1080 --left-of DP2-1 && setxkbmap -option ctrl:nocaps && setxkbmap -option compose:ralt && setxkbmap -option numpad:mac";
        "r" = "exec xrandr --output DP2-1 --primary --mode 1920x1080 --output eDP1 --mode 1920x1080 --left-of DP2-1 && xbacklight -set 100;";

        # Mirror
        # xrandr --output eDP1 --rate 60 --mode 1920x1080 --fb 1920x1080 --output DP1 --mode 1920x1080 --same-as eDP1
        # To turn off, use position, e.g.:
        # xrandr --output DP1 --right-of eDP1

        # back to normal: Enter or Escape
        "Return" = "mode default";
        "Escape" = "mode default";
      };
    };

  };
}
