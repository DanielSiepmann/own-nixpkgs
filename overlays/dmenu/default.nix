self: super: {
  dmenu = super.dmenu.overrideAttrs(old: {
    patches = (if old.patches == null then [] else old.patches) ++ [
      ./settings.patch
    ];
  });
}
