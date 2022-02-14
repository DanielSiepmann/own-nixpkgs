{
  description = "Composer v2 for single legacy project.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    phps.url = "github:fossar/nix-phps/master";
  };

  outputs = {
    self,
    nixpkgs,
    phps
  }: {
    defaultPackage.x86_64-linux =
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      php = phps.packages.x86_64-linux.php81;
      version = "2.2.6";
    in pkgs.stdenv.mkDerivation {
      pname = "composer";
      inherit version;

      src = pkgs.fetchurl {
        url = "https://getcomposer.org/download/${version}/composer.phar";
        sha256 = "sha256-HVhIa4keWengZMDVS7OFOPdNYBT3VIFULGmthNTpdwQ=";
      };

      dontUnpack = true;

      nativeBuildInputs = [ pkgs.makeWrapper ];

      installPhase = ''
        runHook preInstall
        mkdir -p $out/bin
        install -D $src $out/libexec/composer/composer.phar
        makeWrapper ${php}/bin/php $out/bin/composer \
        --add-flags "$out/libexec/composer/composer.phar" \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.unzip ]}
        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "Dependency Manager for PHP";
        license = licenses.mit;
        homepage = "https://getcomposer.org/";
        changelog = "https://github.com/composer/composer/releases/tag/${version}";
      };
    };
  };
}
