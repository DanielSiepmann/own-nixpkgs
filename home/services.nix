{ config }:

{

    dunst = import ./services/dunst.nix {
      inherit config;
    };

    languagetool.enable = true;
    mailhog.enable = true;
    nextcloud-client.enable = true;

}
