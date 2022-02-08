self: super: {
  dmenu-custom-scripts = super.stdenv.mkDerivation {
    name = "dmenu-custom-scripts";

    src = ./src;

    buildPhase = ''
      mkdir -p "$out/bin"
    '';

    installPhase = ''
      declare -xp
      cp -r * "$out/bin/"
      sed -i 's#\$dmenu#${super.pkgs.dmenu}/bin/dmenu#' $out/bin/dmenu_selection
      sed -i "s#\$out#$out/bin#" $out/bin/dmenu_selection
      sed -i 's#\$dmenu#${super.pkgs.dmenu}/bin/dmenu#' $out/bin/scripts/*
      sed -i 's#\$dunstctl#${super.pkgs.dunst}/bin/dunstctl#' $out/bin/scripts/*
    '';
  };
}
