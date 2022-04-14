{
  description = "First example for soziopolis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
    typo3.url = "/home/daniels/.config/nixpkgs/flakes/projects/web/typo3";
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
      packageJsonPath = "packages/soziopolis/Build/";
    in rec {
      apps = rec {
        compileAssets = typo3.lib.compileAssets {
          inherit pkgs packageJsonPath;
          nodePkg = pkgs.nodejs-14_x;
        };
        watchAssets = typo3.lib.watchAssets {
          inherit pkgs compileAssets packageJsonPath;
          nodePkg = pkgs.nodejs-14_x;
        };
      };

      defaultApp = apps.compileAssets;
    }
  );
}
