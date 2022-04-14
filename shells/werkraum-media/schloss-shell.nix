{ pkgs ? import <nixpkgs> { } }:

let
  compileAssets = pkgs.writeShellApplication {
    name = "compileAssets";
    runtimeInputs = [
      pkgs.nodejs-12_x
      pkgs.nodePackages.npm
    ];
    text = ''
      rm -rf "$PROJECT_ROOT/packages/sitepackage/Resources/Public/Stylesheets"
      rm -rf "$PROJECT_ROOT/packages/sitepackage/Resources/Public/JavaScripts"
      rm -rf "$PROJECT_ROOT/packages/sitepackage/Build/node_modules/"
      npm ci --prefix="$PROJECT_ROOT/packages/sitepackage/Build/"
      npm run style --prefix="$PROJECT_ROOT/packages/sitepackage/Build/"
      npm run js --prefix="$PROJECT_ROOT/packages/sitepackage/Build/"
    '';
  };

in pkgs.mkShell {
  name = "TYPO3Website";
  buildInputs = [
    compileAssets
    pkgs.nodejs-12_x
  ];

  shellHook = ''
    export PROJECT_ROOT="$(pwd)"
  '';
}
