{ config, pkgs }:

{
  enable = true;

  numlock.enable = true;

  # TODO: Check how to set those options somewhere else?
  initExtra = ''
    eval $(ssh-agent)

    xrandr --auto --brightness 1

    xbacklight -set 25
    xsetroot -solid "#2E3436"
    xset s off

    xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Tapping Enabled' 1
    # Use natural scrolling for trackpad
    xinput --set-prop 'DELL07E6:00 06CB:76AF Touchpad' 'libinput Natural Scrolling Enabled' 1
    # Increase mouse speed
    xinput --set-prop 13 'libinput Accel Speed' 1
  '';

  windowManager.i3 = import ./windowManager/i3.nix {
    inherit config pkgs;
  };
}
