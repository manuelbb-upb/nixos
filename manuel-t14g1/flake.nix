{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    scientific-nix-pkgs = {
      url = "github:manuelbb-upb/scientific-nix-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    allhosts = {
      url = "path:./..";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.scientific-nix-pkgs.follows = "scientific-nix-pkgs";
    };
  };

  outputs = inputs@{self, allhosts, ...}:allhosts;
}
