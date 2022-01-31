self: super: {
  dmenu = super.dmenu.overrideAttrs( oa: {
    patches = [
      ./settings.patch
    ];
  });
}
