{
  config
  , domain
  , relativeDocumentRoot
}:

let
  documentRoot = "${config.custom.web-development.rootPath}/${relativeDocumentRoot}";
in {
  services = {

    httpd.virtualHosts.${domain} = {
      forceSSL = true;
      sslServerCert = "${config.custom.web-development.certFolder}${domain}.pem";
      sslServerKey = "${config.custom.web-development.certFolder}${domain}-key.pem";

      inherit documentRoot;

      extraConfig = ''
        <Directory ${documentRoot}>
            AllowOverride All
            Require all granted
            Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec
            DirectoryIndex index.html Index.html
        </Directory>
      '';
    };

  };
}
