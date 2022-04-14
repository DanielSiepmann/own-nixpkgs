{ pkgs ? import <nixpkgs> { } }:

let
  compileAssets = pkgs.writeShellApplication {
    name = "compileAssets";
    runtimeInputs = [
      pkgs.nodejs-14_x
      pkgs.nodePackages.npm
    ];
    text = ''
      rm -rf "$PROJECT_ROOT/packages/soziopolis/Build/node_modules/"
      npm ci --prefix="$PROJECT_ROOT/packages/soziopolis/Build/"
      npm run style --prefix="$PROJECT_ROOT/packages/soziopolis/Build/"
      npm run js --prefix="$PROJECT_ROOT/packages/soziopolis/Build/"
    '';
  };

in pkgs.mkShell {
  name = "TYPO3Website";
  buildInputs = [
    compileAssets
    pkgs.nodejs-14_x
  ];

  shellHook = ''
    export PROJECT_ROOT="$(pwd)"
  '';
}
