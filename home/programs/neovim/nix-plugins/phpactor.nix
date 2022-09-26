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
  version = "3e7cb48b0ca429f92bcd57c236c39f170e9d23b1";
  src = fetchurl {
    url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
    sha256 = "sha256-JX6aLuzmJ4rrcG0FNgzt2zITmnRrpitUI591oPn+fhY=";
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
