#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bundix zlib

set -o errexit
set -o nounset

rm -f Gemfile.lock gemset.nix
BUNDLE_FORCE_RUBY_PLATFORM=true bundix --magic
rm -rf .bundle vendor
