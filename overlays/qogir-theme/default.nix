self: super: {
  qogir-theme = super.qogir-theme.overrideAttrs(old: {
    patches = (old.patches or []) ++ [
      # TODO: Find out how to properly render inactive menu items
      # TODO: Find out how to properly render background of selected text
      # TODO: Properly adjust svgs and then compile them
      ./colors.patch
    ];
  });
}
