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

`shells/`
    Holds shells for customer projects.
    The customers are not aware of Nix and I don't want to stress them.
    I use this folder to have them in version control and symlink them into the
    project.

Update
------

Update can be done via `custom-update-system` package which is available within
the overlay.

Manual changes
--------------

List of manual needed changes for various reasons.

* Allow gdm3 to use xsessions as login.
  Add the following content as `/usr/share/xsessions/xsession.desktop`:

      [Desktop Entry]
      Name=XSession
      Comment=This session uses the custom xsession file
      Exec=/etc/X11/Xsession
      Type=Application
      X-DesktopNames=GNOME-Flashback;GNOME;
      X-Ubuntu-Gettext-Domain=gnome-flashback

  This is used by gdm3 (installed via ubuntu host) to allow logging in via
  xsession which will pick up all the settings generated by home-manager.

  Do not forget to call `sudo desktop-file-install xsession.desktop` to make
  system aware of the file.

Todos
-----

Additions:

* https://github.com/altdesktop/playerctl#selecting-the-most-recent-player in
  order to not worry about current media player, control whatever was last

* https://github.com/cantino/mcfly as replacement for shell history search?

* https://github.com/evilsocket/opensnitch/wiki for better network control?

* https://github.com/darrenburns/dunk diff alternative

* Add languagetool integration (via ale?) into Neovim (for rst, markdown, git commit?)

* Integrate https://github.com/Wilfred/difftastic for diffing source code
  https://github.com/nix-community/home-manager/pull/2850

* Try out pidgin? Does it work with slack and ms teams videos?

* Check out other themes? https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/data/themes
  Used by some GUI tools like firefox, thunderbird, etc.
  https://www.gnome-look.org/browse/ might have screenshots for themes.

  Use https://github.com/themix-project/oomox to adjust / create own theme
  following my existing colors?

Migration:

* Migrate ssh config (I don't really like to expose customer server names and configs to outer world, how to handle?)

* Migrate PGP?

   * Right now I've installed gnupg2, gnupg, gpg on ubuntu

* Migrate home manager to use flake for better rollback support if update breaks something.

* Maybe PR upstream: `./home/modules/programs/languagetool.nix`.

* i3lock-color

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
