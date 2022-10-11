{ config }:

{
  enable = true;

  homedir = "${config.xdg.dataHome}/gnupg";

  publicKeys = [

    {
      source = ./../../gpg/publickeys/myown.pgp;
      trust = "ultimate";
    }

  ];
}
