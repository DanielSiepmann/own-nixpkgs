{ config, pkgs }:

{
  enable = true;
  keys = [
    "id_rsa"
    "id_ed25519"
  ];
  enableBashIntegration = false;
  enableFishIntegration = false;
  enableZshIntegration = true;
  enableXsessionIntegration = false;
}
