{ config, pkgs, lib, inputs, ... }:

{
  home.shellAliases = {
    "vimHome" = "vimcd /etc/nixos/home_configs/manuel";
    "vimBase" = "vimcd /etc/nixos";
  };

  gtk.enable = true;

  qt = {
    enable = true;
    platformTheme = {
      name = "kvantum";
    };
    style = {
      name = "kvantum";
      catppuccin.enable = true;
    };
  };
  # When this issue is solved,
  # https://github.com/danth/stylix/issues/489
  # then we can delete catpuccin for kde styling

  #catppuccin.pointerCursor.enable = true;
  #catppuccin.pointerCursor.accent = "dark";

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "manuel";
  home.homeDirectory = "/home/manuel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    wev           # debug Wayland events
    jq            # parse JSON in terminal
    killall      
    htop 
    hwinfo
    fastfetch      # print system information in terminal
    filelight       # KDE tool for storage analysis
    nnn             # terminal file explorer
    bitwarden       # password manager
    bitwarden-cli   # password manager command line tool
    duplicacy
    chezmoi
    protonvpn-gui
    networkmanager-openconnect  # work VPN
    openconnect                 # work VPN
    google-chrome
    #julia
    texliveFull
    (pkgs.callPackage ./segoe_ui.nix {})  # additional Microsoft font
    libreoffice-qt
    hunspell              # spellchecking for libreoffice
    hunspellDicts.en_US
    hunspellDicts.de_DE
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/manuel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  fonts.fontconfig.enable = true;
  
  imports = [
    inputs.scientific-fhs.nixosModules.default
    ./stylix.nix
    ./plasma.nix
    ./email_tud.nix
    ./firefox.nix
    ./brave.nix
    ./vscode.nix
    ./vim.nix
    #./nu.nix
    ./zsh.nix
    ./hyprland.nix
    ./waybar.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  programs.scientific-fhs = {
    enable = true;
    juliaVersions = [
      {
        version="1.11.1";
        default=true;
      }
    ];
    enableNVIDIA = false;
    enableGraphical = true;
  };
  # Enable and configure git
  programs.git = {
    enable = true;
    userName = "manuelbb-upb";
    userEmail = "manuelbb@mail.uni-paderborn.de";
  };

  programs.kitty = {
    enable = true;
    # font is managed by stylix now
    # font = {
    #   name = "ComicShannsMono Nerd Font";
    #   package = pkgs.nerdfonts;
    # };
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };

  # locate packages for missing executables
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # `direnv` to automatically activate dir environments
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".duplicacy/preferences".source = ./duplicacy_preferences.txt;
}
