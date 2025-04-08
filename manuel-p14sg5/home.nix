{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../common/home.nix
    ./email.nix
  ];

  home.packages = with pkgs; [
    mattermost
  ];

  stylix.image = ../wallpapers/jisca-lucia-PM9OTjUk-iY-unsplash.jpg;
}
