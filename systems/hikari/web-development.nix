{ pkgs, lib, ... }:

{
  imports = [
    ./web-development/daniel-siepmann.localhost.nix
  ];

  services = {
    httpd = {
      enable = true;

      user = "daniels";

      adminAddr = "apache@hikari.localhost";

      extraModules = [
        "info"
        "rewrite"
        "proxy"
        "proxy_fcgi"
      ];

      virtualHosts."localhost".locations."/server-info" = {
        extraConfig = ''
          SetHandler server-info
          Require local
        '';
      };
    };
  };
}
