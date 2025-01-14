{ config, lib, pkgs, modulesPath, ... }:

{

  services.fwupd.enable = true;

  boot.initrd.kernelModules = [ "i915" ];

  boot.kernelParams = [ 
    "acpi_backlight=vendor" # This makes the the brightness keys work!!
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1" # About this, I am not sure... could bisect
    "i915.force_probe=7d55"
    "btusb.enable_autosuspend=n"
  ];
  # Make Trackpoint slower, see https://wiki.archlinux.org/title/TrackPoint
  # To get device information, obtain `libinput` (`nix-shell -p libinput`), and find trackpoint with
  # `libinput list-devices`
  # Then run `udevadm test /dev/input/eventX`.
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Lenovo P14s G5 Trackpoint]
    MatchName=*TPPS/2 ALPS TrackPoint
    MatchDMIModalias=dmi:*svnLENOVO:*:pvrThinkPadP14sGen5:*
    AttrTrackpointMultiplier=0.4
  '';

  # Load NVIDIA drivers for graphical sessions:
  services.xserver.videoDrivers = [
    "nvidia"
    #"displaylink"
  ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # # Seems to only work with X11...
    # prime = {
    #   sync.enable = true;
    #   intelBusId = "PCI:0:2:0";
    #   nvidiaBusId = "PCI:1:0:0";
    # };
  };
  # Alternative for Plasma|Wayland
  # environment.variables = {
  #   #KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
  #   __GLX_VENDOR_LIBRARY_NAME="nvidia";
  # };

}
