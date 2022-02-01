self: super: {
  dunst = super.dunst.overrideAttrs(oldAttrs: rec {
    patches = [
      ./systemd-service.patch
    ];
  });
}
