{ writeShellApplication }:

writeShellApplication {
  name = "custom-update-ubuntu-system";

  text = ''
    sudo apt update
    sudo apt list --upgradable
    sudo apt upgrade -V -y
    sudo apt autoremove -y

    sudo fwupdmgr refresh
    sudo fwupdmgr get-updates
    fwupdmgr update -y
  '';
}
