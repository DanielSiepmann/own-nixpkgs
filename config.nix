{
  # Define packages to install.
  # Provides convenient list for sharing and porting.
  # Install via: nix-env -iA nixpkgs.myPackages
  # See: https://nixos.org/manual/nixpkgs/stable/#sec-building-environment
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        # System tools
        pkgs.dmenu
        pkgs.st
        pkgs.dunst
        pkgs.i3lock-color

        # Dev tools
        pkgs.litecli
        pkgs.mkcert

        # Media
        pkgs.vlc
      ];
    };
  };
}
