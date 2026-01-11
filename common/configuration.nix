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
  imports =  [ ];
  
  # Bootloader.

  ## Linux kernel to use:
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    evdi
  ]; # I think this was needed for displaylink?

  boot.supportedFilesystems = [ "ntfs" ];

  ## Grub configuration:
  boot.loader = {
    timeout = null;
    grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      configurationLimit = 5;
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ../wallpapers/Wassily_Kandinsky_Composition_VIII.jpg;
  stylix.targets = {
    gtk.enable = true;
    grub.enable = true;
  };
  stylix.fonts = {
    monospace = {
      name = "ComicShannsMono Nerd Font";
      package = pkgs.nerd-fonts.comic-shanns-mono;
    };
  };

  stylix.homeManagerIntegration = {
    autoImport = true;    # make hm module available for any user
    followSystem = true;  # instead of defaults, follow system settings
  };

  # Make flake registry entry `nixpkgs` (used by `nix` commands)
  # match the `nixpkgs` used by “old” commands relying on `NIX_PATH`, see
  # https://nixos-and-flakes.thiscute.world/best-practices/nix-path-and-flake-registry
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.channel.enable = false;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    experimental-features = [ 
      "nix-command"
      "flakes" 
    ];
    ## community cache (e.g. for CUDA)
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # add community flake templates:
  nix.registry.communityTemplates.to = {
    owner = "nix-community";
    repo = "templates";
    type = "github";
  };

  # add private flake templates:
  nix.registry.myTemplates.to = {
    owner = "manuelbb-upb";
    repo = "nix-templates";
    type = "github";
  };

  # make tmp file lifespan shorter
  environment.etc."tmpfiles.d/tmp.conf".text = ''
    q /tmp 1777 root root 3d
    q /var/tmp 1777 root root 6d
  '';
      
  networking.hostName = hostname; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  fonts.fontDir.enable = true;
  fonts.packages = (with pkgs; [
    julia-mono
    lmodern
    corefonts
    gyre-fonts
  ]) ++ 
  builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts) ++ [
    (pkgs.callPackage ./segoe_ui.nix {})  # additional Microsoft font
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.hardware.bolt.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    # You can disable this if you're only using the Wayland session. 
    # (Not sure if the above comment is true still.)
    enable = true;
  };

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  #programs.hyprland.enable = true;

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager = {
  #   autoLogin = {
  #     enable = true;
  #     user = "manuel";
  #   };
    # `autoLogin` disabled to unlock kwallet
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "plasma";
  };

  security.pam.services = {
    sddm = {
      # automatically unlock kwallet upon login
      kwallet = {
        enable = true;
        package = pkgs.kdePackages.kwallet-pam;
        forceRun = true;
      };
    };
  };

  # Configure keymap
  services.xserver.xkb = {
    layout = "de";
    variant = "neo";
    model = "pc105";
  };

  # Configure console keymap
  console.keyMap = "de";  # or "neo"

  xdg = {
    menus = {
      enable = true;
    };
    mime = {
      enable = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.libinput = {
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.manuel = {
    isNormalUser = true;
    description = "Manuel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  # Executing unpatched binaries:
  programs.nix-ld = {
    enable = true;
    libraries = options.programs.nix-ld.libraries.default ++ (
      with pkgs; [
        linux-pam   # installed anyways, required by Matlab
        mesa        # installed anyways, required by Matlab
      ]
    );
  };
  # set `/bin` and `/usr/bin` for unpatched binaries:
  services.envfs.enable = true;

  programs.zsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ausweisapp
    ## basic tools
    htop
    wget
    curl
    git
    ripgrep
    killall
    coreutils
    zip
    unzip
    unrar
    wl-clipboard
    pciutils    # lspci etc
    usbutils    # lsusb
    lsof        # `lsof +f -- /dev/sdX`
    gparted
    wev           # debug Wayland events
    mesa-demos  # glxinfo
    kdePackages.kdeconnect-kde
    ### sys info
    inxi        # system information
    fastfetch   # print system information in terminal
    kdePackages.filelight   # KDE tool for storage analysis
    inputs.nix-alien.packages.${system}.nix-alien   # companion to nix-ld
      # `nix-alien-ld myapp` spawn inside shell with `NIX_LD_LIBRARY_PATH` populated
      # `nix-alien-find-libs myapp` list needed deps
    ### browser
    google-chrome
    ### vpn
    networkmanager-openconnect  # work VPN
    openconnect                 # work VPN
    ### office
    gimp
    libreoffice-qt
    (hunspell.withDicts ( with hunspellDicts; [ # spellchecking for libreoffice
      en_US
      de_DE
    ]))
    ### backup tools
    chezmoi
    duplicacy       # backup tool for data
    bitwarden-desktop       # password manager
    bitwarden-cli   # password manager command line tool
    ## shell + terminal
    zsh
    kitty
    nnn
    ffmpeg            ## for preview in nnn + media in general
    ffmpegthumbnailer ## for preview in nnn
    imagemagick       ## for previews in kitty / nice-to-have anyways
    ## programming
    python3     # just nice to have a global python available from time to time
    gcc         # A C compiler does not hurt and is required 
                # by many other tools (e.g., Julia's PackageCompiler)
    gnumake     # `make` also nice to have
    ((vim-full.override {}).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [
          vim-nix
          vim-lastplace
          vim-wayland-clipboard
        ];
        opt = [];
      };
      vimrcConfig.customRC = ''
      " Turn on syntax highlighting by default
      syntax on
      '';
    })
  ];

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  environment.variables = {
    EDITOR="vim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPorts = [ 24727 ]; # Ausweisapp
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
