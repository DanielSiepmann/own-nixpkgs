{ config, pkgs, ownLib }:

let
  initExtraHikari = ''
    xrandr --auto --output eDP-1 --brightness 1 --scale 1.25x1.25

    # Use natural scrolling for trackpad
    xinput --set-prop bcm5974 'libinput Natural Scrolling Enabled' 1
  '';
  initExtraHikari2 = ''
    xrandr --auto --brightness 1

    # Enable tapping instead of phsyical click
    xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Tapping Enabled' 1

    # Use natural scrolling for trackpad
    xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Natural Scrolling Enabled' 1
  '';
in {
  enable = true;

  numlock.enable = true;

  initExtra = (if ownLib.onHikari {} then initExtraHikari else initExtraHikari2) + ''
    # Set backlight of output
    xbacklight -set 25

    # Set background color
    xsetroot -solid "#2E3436"

    # Disable screen saver
    xset s off

    # Increase mouse speed
    xinput --set-prop 13 'libinput Accel Speed' 1
  '';

  windowManager.i3 = import ./windowManager/i3.nix {
    inherit config pkgs ownLib;
  };
}
