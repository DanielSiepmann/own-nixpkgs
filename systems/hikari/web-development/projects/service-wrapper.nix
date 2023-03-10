{ pkgs, lib, config, ... }:

let
  domain = "mailhog.localhost";
in {
  services = {

    httpd.virtualHosts.${domain} = {
      forceSSL = true;
      sslServerCert = "${config.custom.web-development.certFolder}${domain}.pem";
      sslServerKey = "${config.custom.web-development.certFolder}${domain}-key.pem";

      extraConfig = ''
        RequestHeader unset Authorization
        ProxyRequests Off
        ProxyPreserveHost On
        ProxyPass / http://localhost:8025/
        ProxyPassReverse / http://localhost:8025/

        # Mailhog specific
        <LocationMatch /api/v2/websocket>
          ProxyPass ws://localhost:8025/api/v2/websocket
        </LocationMatch>
      '';
    };

  };
}
