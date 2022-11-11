{ writeShellApplication }:

writeShellApplication {
  name = "custom-update-system";

  text = ''
    nix-channel --update
    home-manager switch

    oldVersion=$(home-manager generations | head -n 2 | tail -n 1 | cut -d' ' -f 7)
    newVersion=$(home-manager generations | head -n 1 | cut -d' ' -f 7)
    nvd diff "$oldVersion" "$newVersion"

    home-manager expire-generations '-30 days'
    nix-env --delete-generations +5
    nix store gc
    nix store optimise
  '';
}
