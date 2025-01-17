# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/310f480c-3e52-484a-a9e0-747118c755cf";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-4129ecf4-5f76-4ddc-9cf8-f37c9fc8d655".device = "/dev/disk/by-uuid/4129ecf4-5f76-4ddc-9cf8-f37c9fc8d655";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D69B-3213";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wwan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Make Trackpoint slower, see https://wiki.archlinux.org/title/TrackPoint
  # To get device information, obtain `libinput` (`nix-shell -p libinput`), and find trackpoint with 
  # `libinput list-devices`
  # Then run `udevadm test /dev/input/eventX`.
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Lenovo T14 G1 Trackpoint]
    MatchName=*TPPS/2 ALPS TrackPoint
    MatchDMIModalias=dmi:*svnLENOVO:*:pvrThinkPadT14Gen1:*
    AttrTrackpointMultiplier=0.4
  '';

  # Install GPU monitoring tool (similar to `htop` but for AMD GPU):
  environment.systemPackages = [
    pkgs.amdgpu_top
  ];
}
