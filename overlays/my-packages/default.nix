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
      self.mycli
      self.mkcert

      # Writing
      self.languagetool

      # Media
      self.vlc
    ];
  };
}
