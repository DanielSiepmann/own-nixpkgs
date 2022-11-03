{ config, pkgs, ownLib }:

{
  enable = if ownLib.onHikari {} then false else true;
  keys = if ownLib.onHikari {} then ["id_ed25519"] else ["id_rsa" "id_ed25519"];
  enableBashIntegration = false;
  enableFishIntegration = false;
  enableZshIntegration = if ownLib.onHikari {} then false else true;
  enableXsessionIntegration = false;
}
