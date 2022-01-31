let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) buildEnv;

in buildEnv {
  name = "my packages";
  paths = [  ]
    # System tools
    ++ [ pkgs.dmenu pkgs.st pkgs.dunst pkgs.i3lock-color ]
    # Dev tools
    ++ [ pkgs.litecli pkgs.mkcert ]
    # Media
    ++ [ pkgs.vlc ]
    ;
}
