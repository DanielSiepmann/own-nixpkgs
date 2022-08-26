{ pkgs }:

{
  enable = true;

  plugins = [
    pkgs.pidgin-window-merge
    pkgs.purple-slack
    # Waiting for https://github.com/NixOS/nixpkgs/issues/188384 to switch back to official package
    # pkgs.purple-signald
    (pkgs.callPackage ./../packages/purple-signald { })
    (pkgs.callPackage ./../packages/purple-mattermost { })
    (pkgs.callPackage ./../packages/purple-microsoft-teams { })
    (pkgs.callPackage ./../packages/purple-libnotify { })
    (pkgs.callPackage ./../packages/purple-events { }) # Dependency
  ];

}
