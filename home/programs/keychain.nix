{ config, pkgs, ownLib }:

{
  enable = true;
  keys = if ownLib.onHikari {} then ["id_ed25519"] else ["id_rsa" "id_ed25519"];
  enableBashIntegration = false;
  enableFishIntegration = false;
  enableZshIntegration = true;
  enableXsessionIntegration = false;
}
