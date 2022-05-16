{ stdenv, fetchFromGitHub, makeWrapper, git, unzip, lib, php, composer }:
let
  pname = "phpactor";
  version = "ad43a19480d016a140df7fbd8650439b4ff39d5b";
in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "phpactor";
    repo = pname;
    rev = version;
    sha256 = "sha256-E4CEmVSusV3ZzGO88BTlnUz+K1AGd6hfuY0Ur4e6oyk=";
  };

  nativeBuildInputs = [
    makeWrapper
    git
  ];

  installPhase = ''
    runHook preInstall
    ${composer}/bin/composer install --no-interaction --optimize-autoloader --no-dev
    makeWrapper ${php}/bin/php $out/bin/phpactor \
      --prefix PATH : ${lib.makeBinPath [ composer ]}
    runHook postInstall
  '';

  postInstall = ''
    rm -rf tests requirements.txt phpunit.xml.dist phpstan* Makefile phpbench.json .git* build
  '';

  meta = with lib; {
    description = "LSP for PHP as vim plugin";
    license = licenses.mit;
    homepage = "https://phpactor.readthedocs.io/en/master/";
  };
}
