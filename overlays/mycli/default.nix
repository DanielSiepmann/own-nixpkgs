self: super: {
  mycli = super.mycli.overridePythonAttrs(old: {
    # As long as https://github.com/NixOS/nixpkgs/issues/211415is is open
    doCheck = false;
  });
}
