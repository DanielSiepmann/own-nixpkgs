self: super: {
  phpactor = self.callPackage ./phpactor.nix {
    composer = super.php74Packages.composer;
    php = super.php74;
  };
}
