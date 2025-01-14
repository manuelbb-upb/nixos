{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../common/home.nix
    ./email.nix
  ];
}
