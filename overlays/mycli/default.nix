self: super: {
  mycli = super.mycli.overridePythonAttrs(old: {
    patches = (old.patches or []) ++ [
      ./1087-vi-indentation.patch
    ];
  });
}
