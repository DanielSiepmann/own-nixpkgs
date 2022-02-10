{
  description = "Flake for TYPO3 Projects specific to customer wm.";

  outputs = {
    self
  }: {
    lib = {
      compileAssets = { packageJsonPath, nodePkg, pkgs }: pkgs.writeShellApplication {
          name = "compileAssets";
          runtimeInputs = [
            nodePkg
            pkgs.nodePackages.npm
          ];
          text = ''
            npm ci --prefix=${packageJsonPath}
            npm run style --prefix=${packageJsonPath}
            npm run js --prefix=${packageJsonPath}
          '';
      };
      watchAssets = { packageJsonPath, compileAssets, nodePkg, pkgs }: pkgs.writeShellApplication {
          name = "watchAssets";
          runtimeInputs = [
            nodePkg
            pkgs.nodePackages.npm
          ];
          text = ''
            ${compileAssets}/bin/compileAssets
            npm run watch --prefix=${packageJsonPath}
          '';
        };
    };

    defaultTemplate = {
      path = ./template;
    };
  };
}
