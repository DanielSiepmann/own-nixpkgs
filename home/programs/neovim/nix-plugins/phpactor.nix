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
  version = "e7d404c2c6fbe606e5a6374b8e3d0c0d0430487f";
  src = fetchzip {
    url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
    sha256 = "sha256-mZ4MZdo7zNXhnUn7OOMfM0hNJe0YFygQ9LMl3YZX0+I=";
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
