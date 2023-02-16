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
  version = "3e7cb48b0ca429f92bcd57c236c39f170e9d23b1";
in vimUtils.buildVimPluginFrom2Nix {
  inherit pname version;
  src = fetchurl {
    url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
    sha256 = "JX6aLuzmJ4rrcG0FNgzt2zITmnRrpitUI591oPn+fhY=";
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
