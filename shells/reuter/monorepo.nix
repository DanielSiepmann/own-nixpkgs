{
  pkgs ? import <nixpkgs> { }
}:

let

  projectFrontendReinstall = pkgs.writeShellApplication {
    name = "project-frontend-reinstall";
    text = ''
      rm -rf node_modules/
      yarn install
    '';
  };

  projectFrontendCompile = pkgs.writeShellApplication {
    name = "project-frontend-compile";
    text = ''
      yarn run build
      ${pkgs.libnotify}/bin/notify-send "done compiling frontend"
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
    export PATH="/home/daniels/Applications/node-v10.24.1-linux-x64/bin/:$PATH"

    export PS1="\033[0;32m\]\W >\[\033[0m\] "

    export typo3DatabaseName=testing
    export typo3DatabaseHost=localhost
    export typo3DatabaseUsername=testing
    export typo3DatabasePassword=testing

    export TYPO3_CONTEXT=Development/dsiepmann
    export TYPO3_DATABASE=emoto2_reuter
    export TYPO3_BASE=https://reuter.emoto2.localhost/
    export BASE_URL=https://reuter.emoto2.localhost/
    export TYPO3_ADDITIONAL_CONFIGURATION=/home/daniels/.local/share/typo3-configuration/AdditionalConfiguration.inc.php
  '';
}
