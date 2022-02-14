self: super:

{
  custom-update-system = super.pkgs.writeShellApplication {
    name = "custom-update-system";

    runtimeInputs = [
      super.pkgs.nix
      super.pkgs.home-manager
    ];

    text = ''
      nix-channel --update
      home-manager switch
      home-manager expire-generations '-30 days'
      nix-env --delete-generations +5
      nix store gc
      nix store optimise
    '';
  };
}
