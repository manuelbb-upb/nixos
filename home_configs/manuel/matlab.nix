{pkgs, inputs, ...}:
{
  /*
  # The following comments are out-dated...
  # For matlab to work we require the input `nix-matlab`, 
  # that I source from https://gitlab.com/doronbehar/nix-matlab
  #
  # For my system, I also need mesa, which I have decided to provide
  # system-wide in the configuration.nix via `hardware.extraPackages`.
  home.file.".config/matlab/nix.sh".text = ''
    INSTALL_DIR=$HOME/bins/MATLAB/R2024b
    '';
    */
  home.sessionVariables = {
    MATLAB_INSTALL_DIR = "$HOME/bins/MATLAB/R2024b";
  };
  home.packages = with inputs.nix-matlab-ld.packages.x86_64-linux; [
    matlab
  ];
}
