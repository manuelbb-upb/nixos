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
  , ... 
}:
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
    (texliveFull.withPackages( ps: with ps; [ tex-gyre tex-gyre-math stix2-otf ] ))
    pdf2svg
    poppler_utils
    kdePackages.plasma-thunderbolt
    ### academia
    logseq
    zotero
    #texliveFull
    #podman-tui  # status of containers in the terminal
    #podman-compose
    (inputs.scientific-nix-pkgs.packages.${pkgs.system}.julia-ld.override {
      version = "1.11.3";
      enable-matlab = true;
    })
    inputs.scientific-nix-pkgs.packages.${pkgs.system}.matlab
    inputs.scientific-nix-pkgs.packages.${pkgs.system}.matlab.shell-script
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
