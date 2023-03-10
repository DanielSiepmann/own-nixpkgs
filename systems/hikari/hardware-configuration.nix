# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
	<nixos-hardware/apple/macbook-air/6>
	(modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3b35e5dd-4b81-4b32-b572-96f1301ac1ef";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-1ad0b141-874e-42c5-9c36-08144b3b6e7a".device = "/dev/disk/by-uuid/1ad0b141-874e-42c5-9c36-08144b3b6e7a";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/8EE4-E230";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/86be72da-47ff-404f-a4ba-e078ea151e99"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20u2.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
