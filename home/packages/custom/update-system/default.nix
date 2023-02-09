{ writeShellApplication }:

writeShellApplication {
  name = "custom-update-system";

  text = ''
    nix-channel --update
    home-manager build

    echo "fetch old version"
    oldVersion=$(home-manager generations | head -n 2 | tail -n 1 | cut -d' ' -f 7)
    nvd diff "$oldVersion" ./result
    rm ./result

    read -p "Continue with update? [Yy]" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi

    home-manager switch

    home-manager expire-generations '-30 days'
    nix-env --delete-generations +5
    nix store gc
    nix store optimise
  '';
}
