{
  vimUtils,
  fetchurl,
  makeWrapper,
  lib,
  php80,
  php80Packages,
  git
}:

vimUtils.buildVimPluginFrom2Nix rec {
  pname = "phpactor";
  version = "382bac189528b216715e9bc750f8160ac69b6d10";
  src = fetchurl {
    url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
    sha256 = "sha256-/L76wrSKZFfHfYyrOX9yj4SjmF19a0S/Hu2+HDMlh20=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  postInstall = ''
      wrapProgram $out/bin/phpactor \
        --prefix PATH : ${lib.strings.makeBinPath [ php80 ]} \
        --prefix PATH : ${lib.strings.makeBinPath [ php80Packages.composer ]} \
        --prefix PATH : ${lib.strings.makeBinPath [ git ]}
  '';
}
