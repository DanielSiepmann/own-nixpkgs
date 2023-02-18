{ pkgs, lib, config, ... }:

import ./../lib/create-typo3.nix {
  inherit config lib pkgs;

  domain = "daniel-siepmann.own.localhost";
  relativeDocumentRoot = "own/daniel-siepmann/project/public/";
  databaseName = "own_danielsiepmann";
  phpPackage = pkgs.php82;
}
