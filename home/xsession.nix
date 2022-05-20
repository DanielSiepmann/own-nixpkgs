{ config, pkgs }:

{
  enable = true;

  numlock.enable = true;

  windowManager.i3 = import ./windowManager/i3.nix {
    inherit config pkgs;
  };
}
