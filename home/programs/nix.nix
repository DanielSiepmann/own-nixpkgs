{ pkgs }:

{
  enable = true;

  package = pkgs.nix;

  settings = {

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://cache.nixos.org"
      "https://fossar.cachix.org"
    ];

    trusted-public-keys = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= fossar.cachix.org-1:Zv6FuqIboeHPWQS7ysLCJ7UT7xExb4OE8c4LyGb5AsE=";

  };

  registry = {

    customer-projects = {
      from = {
        id = "cp";
        type = "indirect";
      };
      to = {
        path = toString ./../../registries/customer-projects;
        type = "path";
      };
    };

  };

}
