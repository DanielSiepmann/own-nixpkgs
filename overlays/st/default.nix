self: super: {
  st = super.st.override {
    patches = [
      ./settings.patch
    ];
  };
}
