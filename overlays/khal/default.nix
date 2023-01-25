self: super: {
  khal = super.khal.overridePythonAttrs(old: {
    # As long as https://github.com/NixOS/nixpkgs/issues/205014 is open
    doCheck = false;
  });
}
