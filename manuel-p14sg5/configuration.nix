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

  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
      enableKvm = true;
      addNetworkInterface = false;
    };
  };
  users.users.manuel.extraGroups = ["disk" "vboxusers"];

  environment.etc."NetworkManager/system-connections/eduroam.nmconnection" = { 
    text = builtins.readFile ../eduroam.nmconnection;
    mode = "0600";
    user = "root";
    group = "root";
  };
}
