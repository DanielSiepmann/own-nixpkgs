{ config, pkgs }:

{
  enable = true;

  numlock.enable = true;

  initExtra = ''
    # Auto setup output and set brightness
    xrandr --auto --brightness 1

    # Set backlight of output
    xbacklight -set 25

    # Set background color
    xsetroot -solid "#2E3436"

    # Disable screen saver
    xset s off

    # Enable tapping instead of phsyical click
    xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Tapping Enabled' 1

    # Use natural scrolling for trackpad
    xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Natural Scrolling Enabled' 1

    # Increase mouse speed
    xinput --set-prop 13 'libinput Accel Speed' 1
  '';

  windowManager.i3 = import ./windowManager/i3.nix {
    inherit config;
  };
}
