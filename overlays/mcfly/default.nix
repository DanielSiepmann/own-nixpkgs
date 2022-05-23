self: super: {
  mcfly = super.mcfly.overrideAttrs (oldAttrs: rec {
    patches = [
      ./colors.patch
    ];
  });
}
