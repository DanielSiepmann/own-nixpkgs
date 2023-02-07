{
  pkgs ? import <nixpkgs> { }
  ,phps ? import <phps>
}:

let

  php = phps.packages.x86_64-linux.php73;
  inherit (pkgs.php81Packages) composer;

  phpWithMoreMemory = php.buildEnv {
    extraConfig = ''
          memory_limit = 4G
    '';
  };

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

  projectPhpstan = pkgs.writeShellApplication {
    name = "project-phpstan";

    runtimeInputs = [
      phpWithMoreMemory
    ];

    text = ''
      ./vendor/bin/phpstan
    '';
  };

  projectCgl = pkgs.writeShellApplication {
    name = "project-cgl";

    runtimeInputs = [
      php
    ];

    text = ''
      ./vendor/bin/ecs
    '';
  };

  projectTestsUnit = pkgs.writeShellApplication {
    name = "project-tests-unit";

    runtimeInputs = [
      php
    ];

    text = ''
      ./vendor/bin/phpunit --testsuite unit --color --testdox
    '';
  };

in pkgs.mkShell {
  name = "TYPO3";
  buildInputs = [
    projectFrontendReinstall
    projectFrontendCompile

    projectPhpstan
    projectCgl
    projectTestsUnit

    php
    composer
  ];

  PS1 = "\\033[0;32m\\]\\W >\\[\\033[0m\\] ";

  typo3DatabaseName = "testing";
  typo3DatabaseHost = "localhost";
  typo3DatabaseUsername = "testing";
  typo3DatabasePassword = "testing";

  TYPO3_CONTEXT = "Development/dsiepmann";
  TYPO3_DATABASE = "reuter_reuter";
  TYPO3_BASE = "https://monorepo.emoto2.localhost/reuter/";
  BASE_URL = "https://monorepo.emoto2.localhost/reuter/";
  TYPO3_ADDITIONAL_CONFIGURATION = "/var/projects/own/typo3-configuration/AdditionalConfiguration.inc.php";

  shellHook = ''
    export PROJECT_ROOT="$(pwd)"
    export PATH="/home/daniels/Applications/node-v10.24.1-linux-x64/bin/:$PATH"
  '';
}
