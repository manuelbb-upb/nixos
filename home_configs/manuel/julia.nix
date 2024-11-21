{pkgs, inputs, ...}:
{
  home.packages = [
    inputs.nix-matlab-ld.packages.${pkgs.system}.julia
  ];
}
