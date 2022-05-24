_:

let
  oldKey = "~/.ssh/id_rsa";
  newKey = "~/.ssh/id_ed25519";

in {
  enable = true;
  matchBlocks = {

    "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = "${newKey}";
    };

  } // import ./ssh-match-blocks.nix {
    inherit oldKey newKey;
  };
}
