{ writeShellApplication }:

writeShellApplication {
  name = "custom-update-nixos-system";

  # Including this doesn't work

  text = ''
    sudo nixos-rebuild switch --upgrade-all

    # shellcheck disable=SC2010
    oldVersion=$(ls -vr /nix/var/nix/profiles/ | grep system | head -n 2 | tail -n 1)
    nvd diff "/nix/var/nix/profiles/$oldVersion" "/nix/var/nix/profiles/system"

    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
    nix store gc
    nix store optimise
  '';
}
