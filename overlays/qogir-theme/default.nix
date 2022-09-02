self: super: {
  qogir-theme = super.qogir-theme.overrideAttrs(old: {
    patches = [
      ./colors.patch
    ];
  });
}
