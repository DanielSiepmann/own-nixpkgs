{
  pkgs ? import <nixpkgs> { },
  phpsChannel ? import <phps>
}:

let
  phps = phpsChannel.packages.x86_64-linux;
  php = phps.php73.buildEnv {
    # We are in CLI Context and need other defaults
    extraConfig = "memory_limit = 5G";
  };
  composer = pkgs.composer1.override {
    inherit php;
  };

in pkgs.mkShell {
  name = "TYPO3";
  buildInputs = [
    php
    composer
  ];

  shellHook = ''
    export PROJECT_ROOT="$(pwd)"

    export PS1="\033[0;32m\]\W >\[\033[0m\] "

    export typo3DatabaseName=testing
    export typo3DatabaseHost=localhost
    export typo3DatabaseUsername=testing
    export typo3DatabasePassword=testing

    export TYPO3_CONTEXT=Development/dsiepmann
    export TYPO3_DATABASE=emoto2_reuter
    export TYPO3_BASE=https://reuter.emoto2.localhost/
    export TYPO3_ADDITIONAL_CONFIGURATION=/home/daniels/.local/share/typo3-configuration/AdditionalConfiguration.inc.php
  '';
}
