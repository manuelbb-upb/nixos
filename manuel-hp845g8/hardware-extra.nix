{ config, lib, pkgs, modulesPath, ... }:

{
  # Install GPU monitoring tool (similar to `htop` but for AMD GPU):
  environment.systemPackages = [
    pkgs.amdgpu_top
  ];

  # Load AMD drivers for graphical sessions:
  services.xserver.videoDrivers = [
    "amdgpu"
  ];
}
