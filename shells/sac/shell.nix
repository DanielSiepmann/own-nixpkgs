{ pkgs ? import <nixpkgs> { } }:

let
  php = pkgs.php74.buildEnv {
    # We are in CLI Context and need other defaults
    extraConfig = "memory_limit = 5G";
  };

  projectCsFixer = pkgs.writeShellApplication {
    name = "projectCsFixer";
    runtimeInputs = [
      php
    ];
    text = ''
      rm -f "$PROJECT_ROOT/.php_cs.cache"
      "$PROJECT_ROOT/vendor/bin/php-cs-fixer" fix --config "$PROJECT_ROOT/.php_cs.php"
      git s;
    '';
  };

  projectPhpStan = pkgs.writeShellApplication {
    name = "projectPhpStan";
    runtimeInputs = [
      php
    ];
    text = ''
      rm -rf "$TMP/phpstan/"
      "$PROJECT_ROOT/vendor/bin/codecept" build
      "$PROJECT_ROOT/vendor/bin/phpstan"
    '';
  };
in pkgs.mkShell {
  name = "TYPO3";
  buildInputs = [
    php
    pkgs.php74Packages.composer
    projectCsFixer
    projectPhpStan
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
