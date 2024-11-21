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

    # hypridle = {
    #   url = "github:hyprwm/hypridle";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager/trunk";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rycee-nurpkgs = {
      url = gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nur.url = github:nix-community/NUR;

    catppuccin.url = "github:catppuccin/nix";

    #split-monitor-workspaces = {
    #  url = "github:Duckonaut/split-monitor-workspaces";
    #  inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    #};

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*
    scientific-fhs = {
      url = "github:manuelbb-upb/scientific-fhs/flake_module";
    };

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
    nix-matlab-ld = {
      url = "github:manuelbb-upb/nix-matlab-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
  };

  outputs = inputs@{ 
    self, 
    nixpkgs, 
    home-manager, 
    hyprland, 
    hyprland-plugins,
    # hyprpanel,
    plasma-manager, 
    nur, 
    catppuccin, 
    #split-monitor-workspaces, 
    hyprsplit,
    stylix,
    #scientific-fhs,
    #nix-matlab,
    nix-matlab-ld,
    nix-alien,
    ... 
  }: 
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};

    displaylink_src = pkgs.fetchurl {
      url = "https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip";
      name = "displaylink-600.zip";
      hash = "sha256-/HqlGvq+ahnuBCO3ScldJCZp8AX02HM8K4IfMzmducc=";
    }; 
  in
  {
    displaylink_overlay = (final: prev: {
      displaylink = prev.displaylink.overrideAttrs (new: old: {
        src = displaylink_src;
      });
    });
  
    nixosConfigurations = {
      "manuel-t14g1" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit self;
        };
        modules = [
          ({self, ...}: {
            nixpkgs.overlays = [ 
              self.displaylink_overlay
              nur.overlay
              # hyprpanel.overlay
            ];
          })
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./configuration.nix
          {
            _module.args = { inherit inputs; };
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = builtins.toString(builtins.currentTime) + ".hmbackup";
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
              catppuccin.homeManagerModules.catppuccin
            ];

            home-manager.users.manuel = import ./home_configs/manuel/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
      };
    };
  };
}
