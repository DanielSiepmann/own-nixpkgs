{ pkgs ? import <nixpkgs> { } }:

let
  compileAssets = pkgs.writeShellApplication {
    name = "compileAssets";
    runtimeInputs = [
      pkgs.nodejs-16_x
      pkgs.nodePackages.npm
    ];
    text = ''
      rm -f "$PROJECT_ROOT/packages/sitepackage/Resources/Public/Stylesheets/main.css"
      rm -rf "$PROJECT_ROOT/packages/sitepackage/Resources/Public/JavaScripts/main.js"
      rm -rf "$PROJECT_ROOT/.build/node_modules/"
      npm ci --prefix="$PROJECT_ROOT/.build/"
      npm run build --prefix="$PROJECT_ROOT/.build/"
    '';
  };

in pkgs.mkShell {
  name = "TYPO3Website";
  buildInputs = [
    compileAssets
    pkgs.nodejs-16_x
  ];

  shellHook = ''
    export PROJECT_ROOT="$(pwd)"
  '';
}
