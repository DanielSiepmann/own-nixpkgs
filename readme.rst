nixpkgs
=======

My personal ``~/.config/nixpkgs`` folder, for sharing, inspiration and retrieving feedback.

.. contents:: Table of Contents

Installation
------------

Install (clone) into ``~/.config/nixpkgs``.

Usage
-----

Install packages as usual.

``my-packages``
---------------

The special ``my-packages`` includes a derivation which holds a set of packages.
The idea: Provide a configuration instead of some state.
It can be installed via ``nix-env -i my-packages``
which also "updates" state accordingly to the current defined set.

Configurations
--------------

Some derivations will provide ready to use configuration.
Those are most likely placed within ``~/.nix-profile/etc/*``.

One can symlink them into ``~/.config/*``.

E.g. ``~/.config/dunst -> ~/.nix-profile/etc/dunst``

systemd units
-------------

Some derivations will provide ready to use systemd units.
Those are most likely placed within ``~/.nix-profile/share/systemd/*``.

One can symlink them into ``~/.config/systemd``.

E.g. ``~/.config/systemd/user/dunst.service -> ~/.nix-profile/share/systemd/user/dunst.service``

Update
------

The following will update the whole system and clean things up::

    nix-channel --update \
      && nix-env -iA nixpkgs.nix nixpkgs.cacert \
      && nix-env --upgrade \
      && nix-env --delete-generations +5 \
      && nix-store --gc

This will update the channel (fetch state of nixpkgs).
It then will update nix itself.
Then upgrade all installed derivations (packages).
Delete old generations, except last 5.
And run garbage collection.

Disclaimer
----------

This is my personal setup for my local laptop running Ubuntu.
I share this for free so everyone can have a look and inspiration or provide feedback to me.

This is not intended to be used by anyone else just by copy and pasting or cloning.
