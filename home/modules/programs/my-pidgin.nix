{ config, pkgs, ... }:

{
  config = {

    programs.pidgin = {
      enable = true;

      plugins = [
        # UI
        pkgs.pidgin-window-merge

        # Protocols
        # Waiting for https://github.com/NixOS/nixpkgs/issues/188384 to switch back to official package
        # pkgs.purple-signald
        pkgs.purple-slack
        (pkgs.callPackage ./../../packages/purple-signald { })
        (pkgs.callPackage ./../../packages/purple-mattermost { })
        (pkgs.callPackage ./../../packages/purple-microsoft-teams { })

        # System integration
        (pkgs.callPackage ./../../packages/purple-libnotify { })
        (pkgs.callPackage ./../../packages/purple-events { }) # Dependency
      ];
    };

    # Necessary to connect to signal from pidgin
    programs.signald.enable = true;

    home.file = {
      pidginGtkRc = {
        target = ".purple/gtkrc-2.0";
        source = ./../../files/purple/gtkrc-2.0;
      };
      pidginSmilies = {
        target = ".purple/smileys/my-own";
        source = ./../../files/purple/smileys;
      };
    };
  };
}
