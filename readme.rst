nixpkgs / nix home-manager
==========================

I currently use Ubuntu and installed nix alongside.
This repository contains my personal ``~/.config/nixpkgs`` folder,
for sharing, inspiration and retrieving feedback.

This includes ``home.nix`` to maintain ``home-manager``,
see: https://nix-community.github.io/home-manager/index.html

.. contents:: Table of Contents

Disclaimer
----------

This is my personal setup for my local laptop running Ubuntu.
I share this for free so everyone can have a look and inspiration or provide feedback to me.

This is not intended to be used by anyone else just by copy and pasting or cloning.

Installation
------------

Install (clone) into ``~/.config/nixpkgs``.

Install ``home-manager`` see: https://nix-community.github.io/home-manager/index.html
Execute ``home-manager switch``

Usage
-----

Add packages to ``home.nix`` and run ``home-manager switch``.

Folder structure
----------------

The folder ``overlays`` contains overlays for nix itself.
E.g. alter packages like patching.

The folder ``home`` is related to extras for home-manager.
It has the following sub folder:

``home/files``
   Holds configuration files.
   home-manager doesn't provide modules for all programs.
   Those files can be loaded via ``biuiltins.readFile``
   or linked via ``home.file.``.

``home/programs``
   Holds home-manager `programs.` entries.
   Each file corresponds to a single program.
   Each file is loaded within ``home.nix``.

``home/services``
   Holds home-manager `services.` entries.
   Each file corresponds to a single service.
   Each file is loaded within ``home.nix``.

``home/systemd``
   Holds custom definitions for systemd services.
   Each file corresponds to a single service.
   Each file is loaded within ``home.nix``.

Update
------

The following will update the whole system and clean things up::

nix-channel --update \
   && home-manager switch \
   && home-manager expire-generations '-30 days' \
   && nix-store --gc

This will update the channel (fetch state of nixpkgs).
It then will update system.
Delete old generations.
And run garbage collection.

Manual changes
--------------

List of manual needed changes for various reasons.

* robo3t desktop file is not linked, that's done by hand for now.

Todos
-----

No particular order:

* Migrate ``./home/services/languagetool.nix`` to a custom module (maybe PR upstream).

* Migrate other local configurations (inspect ``~/.config`` folder)
  All other dotfiles in home dir are already migrated :yay:

* Migrate zsh

* Migrate ssh config (I don't really like to expose customer server names and configs to outer world, how to handle?)

* Migrate PGP?

* Migrate other tools from local system (which are not part of above migrations)

* Migrate other systemd services.

* Migrate other system configurations like keyboard?!

* Migrate desktop environment (is that possible? I select it within ubuntu login screen, guess it needs to be installed or registered somwhere in ubuntu)

* Begin migrating further configuration, e.g. php fpm pools and apache config (Again I don't like customer internals in public repo, how to handle?)

* Switch to stable channels

Ideas
-----

* Maybe I can have a private channel which provides more sensitive info like customer related things and is referenced from here?
  I then can make that repo private but keep this one here public?

Resources
---------

Some resources I found useful (in no particular order):

* https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs

* https://nixos.org/learn.html

* https://nix-community.github.io/home-manager/index.html

* https://nixcloud.io/main/en/
