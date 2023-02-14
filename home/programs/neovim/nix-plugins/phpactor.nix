{
  vimUtils,
  fetchurl,
  makeWrapper,
  lib,
  php82,
  php82Packages,
  git
}:

let
  pname = "phpactor";
  version = "4e89a6965fdaf42a536b56519c7f2e9fe35f90af";
in vimUtils.buildVimPluginFrom2Nix {
  inherit pname version;
  src = fetchurl {
    url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
    sha256 = "C548mTIa+J+LsnQPvGU5kKeWQaRizdv+zu0YgJn+wJA=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  prePatch = ''
    rm -rf .github/ tests/ \
      .gitignore \
      .php-cs-fixer.dist.php \
      CHANGELOG.md \
      composer.json \
      LICENSE \
      Makefile \
      phpactor.schema.json \
      phpbench.json \
      phpstan-baseline.neon \
      phpstan.neon \
      phpunit.xml.dist \
      README.md \
      requirements.txt
  '';


  postInstall = ''
      wrapProgram $out/bin/phpactor \
        --prefix PATH : ${lib.strings.makeBinPath [ php82 php82Packages.composer git]}
  '';
}
