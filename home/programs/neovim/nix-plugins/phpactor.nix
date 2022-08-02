{
  vimUtils,
  fetchzip,
  makeWrapper,
  lib,
  php80,
  php80Packages,
  git
}:

vimUtils.buildVimPluginFrom2Nix rec {
  pname = "phpactor";
  version = "f07b2a65e3b5f84c49a76fadb9752f8cafd7e879";
  src = fetchzip {
    url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
    sha256 = "sha256-I4oKEgXY5N63IIxr4leqm5WHsgtQJXmQhHmmpPDtOGQ=";
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
