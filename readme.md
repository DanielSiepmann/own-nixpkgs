nixpkgs / nix home-manager
==========================

I currently use Ubuntu and installed nix alongside.
This repository contains my personal `~/.config/nixpkgs` folder,
for sharing, inspiration and retrieving feedback.

This includes `home.nix` to maintain `home-manager`,
see: https://nix-community.github.io/home-manager/index.html

Disclaimer
----------

This is my personal setup for my local laptop running Ubuntu.
I share this for free so everyone can have a look and inspiration or provide feedback to me.

This is not intended to be used by anyone else just by copy and pasting or cloning.

Installation
------------

Install (clone) into `~/.config/nixpkgs`.

Install `home-manager` see: https://nix-community.github.io/home-manager/index.html
Execute `home-manager switch`

Usage
-----

Add packages to `home.nix` and run `home-manager switch`.

Folder structure
----------------

The folder `overlays` contains overlays for nix itself.
E.g. alter packages like patching.

The folder `home` is related to extras for home-manager.
It has the following sub folder:

`home/files`
   Holds configuration files.
   home-manager doesn't provide modules for all programs.
   Those files can be added via `xdg.configFile`.

`home/modules`
   Holds nix modules.
   Not all programs provide modules out of the box.
   I add my own here, which I might create PRs for in future.

`home/programs`
   Holds home-manager `programs.` entries.
   Each file corresponds to a single program.
   Each file is loaded within `home.nix`.

`home/services`
   Holds home-manager `services.` entries.
   Each file corresponds to a single service.
   Each file is loaded within `home.nix`.

`flakes/`
    Holds structure with specific flakes.
    Those should provide libraries and template for development projects.

Update
------

The following will update the whole system and clean things up:

    nix-channel --update \
       && home-manager switch \
       && home-manager expire-generations '-30 days' \
       && nix-env --delete-generations +5 \
       && nix store gc \
       && nix store optimise

This will update the channel (fetch state of nixpkgs).
It then will update system.
Delete old generations.
And run garbage collection.

Manual changes
--------------

List of manual needed changes for various reasons.

* .desktop files seem not to be supported by home-manager yet.
  They need to manually be linked, e.g.:

      cd ~/.local/share/applications && ln -s ~/.nix-profile/share/applications/* .

Todos
-----

* Migrate neovim

* Migrate ssh config (I don't really like to expose customer server names and configs to outer world, how to handle?)

* Migrate PGP?

   * Right now I've installed gnupg2, gnupg, gpg on ubuntu

* Migrate firefox (with geckodriver), thunderbird, ungoogled chromium

* Begin migrating local development to execute php. On a per customer project.

  * `flake.nix` and `flake.lock` need to be checked into a repo … How to handle that if customer doesn't want the file?
    Maybe symlinks will work, so I've a dedicated repo with the project flakes and link them into project repos?

* Migrate home manager to use flake for better rollback support if update breaks something.

* Maybe PR upstream: `./home/modules/programs/languagetool.nix`.

* Migrate other system configurations like keyboard?!

* Begin migrating further configuration, e.g. php fpm pools and apache config (Again I don't like customer internals in public repo, how to handle?)
  Does that work? I guess nix (home-manager) shouldn't write outside of user home.
  Maybe within vm as preparation of switch to nix os?

* Migrate desktop environment (is that possible? I select it within ubuntu login screen, guess it needs to be installed or registered somwhere in ubuntu)
  i3-wm, i3, i3lock-color

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
