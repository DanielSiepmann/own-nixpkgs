{ writeShellApplication }:

writeShellApplication {
  name = "custom-update-system";

  text = ''
    nix-channel --update
    home-manager switch
    home-manager expire-generations '-30 days'
    nix-env --delete-generations +5
    nix-index
    oldVersion=$(home-manager generations | head -n 2 | tail -n 1 | cut -d' ' -f 7)
    newVersion=$(home-manager generations | head -n 1 | cut -d' ' -f 7)
    nvd diff "$oldVersion" "$newVersion"
    nix store gc
    nix store optimise
  '';
}
