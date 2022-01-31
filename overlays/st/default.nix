self: super: {
  st = super.st.overrideAttrs( oldAttributes: {
    patches = oldAttributes.patches ++ [
      ./settings.patch
    ];
  });
}
