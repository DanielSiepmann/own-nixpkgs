self: super: {
  dmenu = super.dmenu.override {
    patches = [
      ./settings.patch
    ];
  };
}
