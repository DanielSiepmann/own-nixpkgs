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
  version = "873fa51ae06eb3dd568ac02c111503b88b76e723";
  src = fetchzip {
    url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
    sha256 = "sha256-WTjxYD0iduV+oHyDCNnL8YOg9qTYGo9vZyDATx0O+no=";
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
