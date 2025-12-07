{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../common/home.nix
    ../common/openaudible.nix
    ./email.nix
  ];

  stylix.image = ../wallpapers/mo-zFZeklnMxOw-unsplash.jpg;

  home.packages = with pkgs; [
    orca-slicer
    freecad-wayland
  ];
}
