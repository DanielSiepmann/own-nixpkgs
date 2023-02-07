{
  pkgs
  ,lib
  ,config
  , ...
}:

let
  phps = import <phps>;
in import ./../lib/create-typo3.nix {
  inherit config lib pkgs;

  domain = "monorepo.reuter.localhost";
  relativeDocumentRoot = "company/customers/reuter/monorepo";
  databaseName = "reuter_reuter";
  phpPackage = phps.packages.x86_64-linux.php73;
}
