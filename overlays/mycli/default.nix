self: super: {
  mycli = super.mycli.overridePythonAttrs(old: {
    # As long as https://github.com/NixOS/nixpkgs/issues/211415 is open
    # Fixed with https://github.com/NixOS/nixpkgs/commit/fd6c52733b95ee8aff5cc6f18e1c8df17a5ea809
    # Waiting for fix to arrive
    doCheck = false;
  });
}
