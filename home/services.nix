{ config }:

{

    dunst = import ./services/dunst.nix {
      inherit config;
    };

    gpg-agent = import ./services/gpg-agent.nix {
    };

    languagetool.enable = true;
    mailhog.enable = true;

}
