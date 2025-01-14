{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../common/home.nix
    ./email.nix
  ];

  stylix.image = ../wallpapers/mo-zFZeklnMxOw-unsplash.jpg;
}
