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
  options = {
    custom.web-development = {
      certFolder = lib.mkOption {
        type = lib.types.path;
        default = "${config.custom.web-development.rootPath}/own/mkcert/";
      };
    };
  };

  config = {

    # TODO: Run once before httpd service starts?
    environment.systemPackages = [
      custom-generate-certs
    ];

    # NOTE: Disable until root certificate is generated, then add again
    # Maybe check for file existense and throw proper error message?
    security.pki.certificates = [
      (builtins.readFile "${config.custom.web-development.certFolder}rootCA.pem")
    ];

  };
}
