{ lib, config, ... }:

import ./../lib/create-static.nix {
  inherit config;

  domain = "tea-docs.typo3.localhost";
  relativeDocumentRoot = "typo3/tea/Documentation-GENERATED-temp/Result/project/0.0.0/";
}
