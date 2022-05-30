_:

{
  enable = true;

  publicKeys = [

    {
      source = ./../../gpg/publickeys/myown.pgp;
      trust = "ultimate";
    }

  ];
}
