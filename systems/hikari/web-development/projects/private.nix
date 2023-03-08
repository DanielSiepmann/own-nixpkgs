{ pkgs, lib, config, ... }:

let

  php = pkgs.php82;

in import ./../lib/create-typo3.nix {
  inherit config lib pkgs php;

  domain = "daniel-siepmann.own.localhost";
  relativeDocumentRoot = "own/daniel-siepmann/project/public/";
  databaseName = "own_danielsiepmann";
}
