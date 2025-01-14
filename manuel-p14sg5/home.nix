{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../common/home.nix
    ./email.nix
    ./hyprland.nix
    ./waybar.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  stylix.image = ../wallpapers/jisca-lucia-PM9OTjUk-iY-unsplash.jpg;
}
