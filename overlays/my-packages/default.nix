self: super: {
  myPackages = super.buildEnv {
    name = "my-packages";
    paths = [
      # System tools
      self.dmenu
      self.st
      self.dunst
      self.i3lock-color

      # Dev tools
      self.litecli
      self.mkcert

      # Media
      self.vlc
    ];
  };
}
