{ pkgs ? import <nixpkgs> { } }:

let
  php = pkgs.php74.buildEnv {
    # We are in CLI Context and need other defaults
    extraConfig = "memory_limit = 5G";
  };

  projectCsFixer = pkgs.writeShellApplication {
    name = "project-csfixer";
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
    name = "project-phpstan-80";
    runtimeInputs = [
      php
    ];
    text = ''
      rm -rf "$TMP/phpstan/"
      "$PROJECT_ROOT/vendor/bin/codecept" build
      "$PROJECT_ROOT/vendor/bin/phpstan"
    '';
  };

  projectPhpStan74 = pkgs.writeShellApplication {
    name = "project-phpstan-74";
    runtimeInputs = [
      php
    ];
    text = ''
      rm -rf "$TMP/phpstan/"
      "$PROJECT_ROOT/vendor/bin/codecept" build
      "$PROJECT_ROOT/vendor/bin/phpstan" --configuration="$PROJECT_ROOT/phpstan_php74.neon"
    '';
  };

  projectRector = pkgs.writeShellApplication {
    name = "project-rector";
    runtimeInputs = [
      php
    ];
    text = ''
      "$PROJECT_ROOT/bin/rector.sh"
    '';
  };

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
    php
    pkgs.php74Packages.composer
    projectCsFixer
    projectPhpStan
    projectPhpStan74
    projectRector
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
