# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  
  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=root,noatime,compress-force=zstd:1,space_cache=v2" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=home,noatime,compress-force=zstd:1,space_cache=v2" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  fileSystems."/mnt/data/files" =
    { device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [ "subvol=files,noatime,compress-force=zstd:1,space_cache=v2" ];
    };

  fileSystems."/mnt/data/games" =
    { device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [ "subvol=games,noatime,compress-force=zstd:1,space_cache=v2" ];
    };

  swapDevices = [ ];
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = "x86_64-linux";
}
