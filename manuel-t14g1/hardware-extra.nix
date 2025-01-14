{ config, lib, pkgs, modulesPath, ... }:

{
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

  # Load AMD drivers for graphical sessions:
  services.xserver.videoDrivers = [
    "amdgpu"
    "displaylink"
    "modesetting"
  ];

  # Enable Vulkan driver:
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];

}
