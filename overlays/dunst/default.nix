self: super: {
  dunst = super.dunst.overrideAttrs(oldAttrs: rec {
    patches = [
      ./settings.patch
      ./systemd-service.patch
    ];
  });
}
