# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config
  , pkgs
  , lib
  , options
  ## extra args
  , inputs
  , hostname
  , custom-julia
  , ... 
}:
let
  tlpkgs = pkgs.texlive.pkgs;
  erewhon-math = tlpkgs.erewhon-math.overrideAttrs (prevAttrs : {
    version = "0.72";
    revision = "r76878";
    outputDrvs = prevAttrs.outputDrvs // {
      tex = prevAttrs.outputDrvs.tex.overrideAttrs {
        name = "erewhon-math-0.72-tex";
        src = pkgs.fetchurl {
          url = "https://ftp.rrze.uni-erlangen.de/ctan/systems/texlive/tlnet/archive/erewhon-math.r76878.tar.xz";
          hash = "sha256-To56Y2Q66H8z9OTkq8HrWPgHRXfrybRC7aepIZjc2Ig=";
        };
        outputHash = "sha256-us8/Lx9LbcSFbj1Oe/bSKQuYCIxfuyKSOZuxwBef/+E=";
      };
    };
  });
in
{
  imports =  [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include additional hardware-specific configuration
    ./hardware-extra.nix
    # Include common config
    ../common/configuration.nix
  ];

  hardware.graphics.extraPackages = with pkgs; [
    ## accelerated video playback with intel cpu
    intel-media-driver # LIBVA_DRIVER_NAME=iHD
    intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    libvdpau-va-gl
  ];

  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
      enableKvm = true;
      addNetworkInterface = false;
    };
  };

  environment.sessionVariables = { 
    LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
    MATLAB_INSTALL_DIR = "$HOME/bins/MATLAB/R2024b";
  };

  environment.systemPackages = (with pkgs; [
    (texliveFull.withPackages( ps: (with ps; [ erewhon cabin tex-gyre tex-gyre-math stix2-otf ] ) ++ [ erewhon-math] ))
    pdf2svg
    poppler-utils
    diffpdf
    kdePackages.plasma-thunderbolt
    ### academia
    logseq
    zotero
    #texliveFull
    #podman-tui  # status of containers in the terminal
    #podman-compose
    custom-julia 
    inputs.scientific-nix-pkgs.packages.${pkgs.stdenv.hostPlatform.system}.matlab
    inputs.scientific-nix-pkgs.packages.${pkgs.stdenv.hostPlatform.system}.matlab.shell-script
    cudatoolkit
    cudaPackages.cudnn
    cudaPackages.libcublas
  ]);
  users.users.manuel.extraGroups = ["disk" "vboxusers"];

  environment.etc."NetworkManager/system-connections/eduroam.nmconnection" = { 
    text = builtins.readFile ../eduroam.nmconnection;
    mode = "0600";
    user = "root";
    group = "root";
  };
}
