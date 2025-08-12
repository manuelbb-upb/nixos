{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager/trunk";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # up-to-date vscode extensions:
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # tools to facilitate running unpatched binaries:
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # »The Nix User Repository (NUR) is a community-driven meta repository for Nix packages«
    # I use it to access the firefox addons provided by `rycee`.
    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    scientific-nix-pkgs = {
      url = "github:manuelbb-upb/scientific-nix-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hypridle = {
    #   url = "github:hyprwm/hypridle";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #split-monitor-workspaces = {
    #  url = "github:Duckonaut/split-monitor-workspaces";
    #  inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    #};

    /*
    scientific-fhs = {
      url = "github:manuelbb-upb/scientific-fhs/flake_module";
    };
    */
  };

  outputs = inputs@{ 
    self, 
    nixpkgs,
    home-manager, 
    hyprland, 
    hyprland-plugins,
    plasma-manager, 
    nur, 
    hyprsplit,
    stylix,
    scientific-nix-pkgs,
    nix-alien,
    # hyprpanel,
    #split-monitor-workspaces,
    ... 
  }: 
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};

    # some of my machines {are/have been} docked to displaylink docks
    # these need special video drivers.
    # first, fetch proprietary source for displaylink driver
    displaylink_src = pkgs.fetchurl {
      url = "https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip";
      name = "displaylink-610.zip";
      hash = "sha256-RJgVrX+Y8Nvz106Xh+W9N9uRLC2VO00fBJeS8vs7fKw=";
    }; 
    # then, prepare an overlay for `nixpkgs` using the source
    displaylink_overlay = (final: prev: {
      displaylink = prev.displaylink.overrideAttrs (new: old: {
        version = "6.1.0-17";
        src = displaylink_src;
      });
    });
  in
  {
    # for multi-machine/multi-host tips see
    # https://discourse.nixos.org/t/flakes-how-to-automatically-set-machine-hostname-to-nixosconfiguration-name/45217 
    /*nixosConfigurations = pkgs.lib.genAttrs [
      "manuel-p14sg5"
      "manuel-t14g1"
      ]*/
    make-nixosConfiguration = (hostname: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit self;
      };
      modules = [
        ({self, ...}: {
          # pass overlays for additional or modified packages:
          nixpkgs.overlays = [ 
            displaylink_overlay
            nur.overlays.default
            # hyprpanel.overlay
          ];
        })
        stylix.nixosModules.stylix
        ./../${hostname}/configuration.nix
        {
          # make `inputs` available in for module in `configuration.nix`
          _module.args = { inherit inputs hostname; };
        }
        # generate home-manager configuration for `hostname`
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = builtins.toString(builtins.currentTime) + ".hmbackup"; # this is impure
          home-manager.sharedModules = [
            plasma-manager.homeManagerModules.plasma-manager
          ];

          home-manager.users.manuel = import ./../${hostname}/home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
        }
      ];
    });
  };
}
