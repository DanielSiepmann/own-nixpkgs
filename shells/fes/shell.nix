{ pkgs ? import <nixpkgs> { } }:

let

  projectFrontendReinstall = pkgs.writeShellApplication {
    name = "project-frontend-reinstall";
    runtimeInputs = [
      pkgs.yarn
    ];
    text = ''
      rm -rf "$PROJECT_ROOT/frontend/node_modules"
      yarn install --cwd="$PROJECT_ROOT/frontend/"
    '';
  };

  projectFrontendCompile = pkgs.writeShellApplication {
    name = "project-frontend-compile";
    runtimeInputs = [
      pkgs.yarn
    ];
    text = ''
      cd "$PROJECT_ROOT/frontend/"
      NODE_OPTIONS=--openssl-legacy-provider yarn build
      cd "$PROJECT_ROOT"
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
    export TYPO3_DATABASE=fes_de
    export TYPO3_BASE=https://fes-de.andreas-wolf.localhost/
    export TYPO3_ADDITIONAL_CONFIGURATION=/home/daniels/.local/share/typo3-configuration/AdditionalConfiguration.inc.php
  '';
}
