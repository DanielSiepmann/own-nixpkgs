{ config, pkgs }:

{
  services = {

    # Temporary fix to OpenGL issue by using GLX.
    # Start nextcloud without GLX support which is fine for me for noe.
    # I don't have a better way for now, then using `pkgs.lib.mkForce` and setting whole value (repeating from modules/services/nextcloud-client.nix).
    nextcloud-client.Service.Environment = pkgs.lib.mkForce [
      "PATH=${config.home.profileDirectory}/bin"
      "QT_XCB_GL_INTEGRATION=none"
    ];

    batteryicon = import ./services/batteryicon.nix {
      inherit pkgs;
    };

  };

  tmpfiles.rules = [
    "L ${config.home.homeDirectory}/.themes - - - - ${config.home.profileDirectory}/share/themes"
    "L ${config.home.homeDirectory}/.icons/${config.gtk.iconTheme.name} - - - - ${config.home.profileDirectory}/share/icons/${config.gtk.iconTheme.name}"
    "L ${config.home.homeDirectory}/.local/share/applications - - - - ${config.home.profileDirectory}/share/applications"
  ];
}
