{ pkgs ? import <nixpkgs> { } }:

let

  projectFrontendReinstall = pkgs.writeShellApplication {
    name = "project-frontend-reinstall";
    runtimeInputs = [
      pkgs.nodejs-14_x
      pkgs.nodePackages.npm
    ];
    text = ''
      rm -rf "$PROJECT_ROOT/frontend/build/*"
      rm -rf "$PROJECT_ROOT/frontend/node_modules/"
      npm ci --prefix="$PROJECT_ROOT/frontend/"
    '';
  };

  projectFrontendCompile = pkgs.writeShellApplication {
    name = "project-frontend-compile";
    runtimeInputs = [
      pkgs.nodejs-14_x
      pkgs.nodePackages.npm
    ];
    text = ''
      rm -rf "$PROJECT_ROOT/frontend/build/*"
      npm run build --prefix="$PROJECT_ROOT/frontend"
      notify-send "done compiling frontend"
    '';
  };

in pkgs.mkShell {
  name = "TYPO3";
  buildInputs = [
    projectFrontendReinstall
    projectFrontendCompile
  ];

  shellHook = ''
    export PROJECT_ROOT="$(pwd)"

    export PS1="\033[0;32m\]\W >\[\033[0m\] "

    export typo3DatabaseName=testing
    export typo3DatabaseHost=localhost
    export typo3DatabaseUsername=testing
    export typo3DatabasePassword=testing

    export TYPO3_CONTEXT=Development/dsiepmann
    export TYPO3_DATABASE=sac_sac
    export TYPO3_BASE=https://www.sac-cas.ch.local/
    export TYPO3_ADDITIONAL_CONFIGURATION=/home/daniels/.local/share/typo3-configuration/AdditionalConfiguration.inc.php
  '';
}
