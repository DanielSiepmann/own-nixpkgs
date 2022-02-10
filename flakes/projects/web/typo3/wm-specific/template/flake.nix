{
  description = "Concrete Flake for TYPO3 project.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
    typo3.url = "git+https://gitea.daniel-siepmann.de/danielsiepmann/nixpkgs?ref=main&dir=flakes/projects/web/typo3/wm-specific";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    typo3
  }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      packageJsonPath = "packages/sitepackage/Build/";
      nodePkg = pkgs.nodejs-14_x;
    in rec {
      apps = rec {
        compileAssets = typo3.lib.compileAssets {
          inherit pkgs packageJsonPath nodePkg;
        };
        watchAssets = typo3.lib.watchAssets {
          inherit pkgs compileAssets packageJsonPath nodePkg;
        };
      };

      defaultApp = apps.compileAssets;
    }
  );
}
