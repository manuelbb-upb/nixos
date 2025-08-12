{
  description = "NixOS configuration";

  inputs = {
    allhost = {
      url = "path:./../common";
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
    nixosConfig-manuel-p14sg5 = allhost.make-nixosConfiguration "manuel-p14sg5";
  };
}
