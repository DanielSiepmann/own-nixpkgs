nixos for hikari
================

Hikari is my old MacBook Air.
It runs NixOS.

I'm using that machine to migrate my existing Ubuntu Setup to NixOS in order to replace Ubuntu in the future.
And I use this Setup for my personal use.

Installation
------------

Update to nixpkgs unstable via:

        nix-channel --add https://nixos.org/channels/nixos-unstable nixos 
        nix-channel --update

See: https://nixos.wiki/wiki/Nix_channels

I also need older php versions:

        nix-channel --add https://github.com/fossar/nix-phps/archive/master.tar.gz phps
        nix-channel --update

Add hardware channel:

        nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
        nix-channel --update

See: https://github.com/NixOS/nixos-hardware

TODOs
-----

* Add docker-compose / podman-compose for Elasticsearch, proxy, solr.
