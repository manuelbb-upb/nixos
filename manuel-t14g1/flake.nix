{
  description = "NixOS configuration";

  inputs = {
    allhost = {
      url = "../common";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
 };

  outputs = inputs@{ 
    self, 
    nixpkgs,
    allhost
  }:
  { 
    nixosConfig-manuel-t14g1 = allhost.make-nixosConfiguration "manuel-t14g1";
  };
}
