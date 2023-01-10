{ config }:

{

    dunst = import ./services/dunst.nix {
      inherit config;
    };

    gpg-agent = import ./services/gpg-agent.nix {
    };

    network-manager-applet.enable = true;

    languagetool.enable = true;
    mailhog.enable = true;

}
