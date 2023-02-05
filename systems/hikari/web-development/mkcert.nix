{ pkgs, lib, config, ... }:

let
  custom-generate-certs = pkgs.writeShellApplication {
    name = "custom-generate-certs";

    runtimeInputs = [
      pkgs.mkcert
    ];

    text = ''
      mkcert -install
      mkdir -p /var/projects/own/mkcert/
      pushd /var/projects/own/mkcert/
      # TODO: Grep from nix config
      mkcert daniel-siepmann.localhost
      mkcert mailhog.localhost
    '';
  };
in {
  # TODO: Run once before httpd service starts?
  environment.systemPackages = [
    custom-generate-certs
  ];

  security.pki.certificateFiles = [
    /var/projects/own/mkcert/rootCA.pem
  ];
}
