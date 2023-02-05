{ pkgs, lib, config, ... }:

let
  certFolder = "/var/projects/own/mkcert";

  domains = builtins.concatStringsSep " " (
    map (domain: "\"${domain}\"") (
      builtins.attrNames config.services.httpd.virtualHosts
    )
  );

  custom-generate-certs = pkgs.writeShellApplication {
    name = "custom-generate-certs";

    runtimeInputs = [
      pkgs.mkcert
    ];

    text = ''
      mkdir -p ${certFolder}
      pushd ${certFolder}
      declare -a domains=(${domains})
      for domain in "''${domains[@]}"
      do
        CAROOT="${certFolder}" mkcert "$domain"
      done
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
