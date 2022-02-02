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
