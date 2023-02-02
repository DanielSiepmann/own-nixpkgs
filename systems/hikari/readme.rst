Update to nixpkgs unstable via:

        nix-channel --add https://nixos.org/channels/nixos-unstable nixos 
        nix-channel --update

See: https://nixos.wiki/wiki/Nix_channels

Ad hardware channel:

        nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
        nix-channel --update
        
See: https://github.com/NixOS/nixos-hardware
