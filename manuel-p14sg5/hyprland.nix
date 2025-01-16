{pkgs, inputs, ...}:
{
  home.shellAliases = {
    "vim-hyprland" = "sudo vim /etc/nixos/home_configs/manuel/hyprland.nix";
  };

  home.packages = with pkgs; [
#    pavucontrol
    lxqt.pavucontrol-qt
    # hyprpanel
    brightnessctl
    networkmanagerapplet
    kdePackages.kwallet-pam
    # blueman
    # screenshots:
    hyprshot
    swappy
  ] ++ [
  ];

  # systemd.user.services.kanshi-hyprland = {
  #   Unit = {
  #     Description = "Start kanshi for hotplug display configuration";
  #     After = "hyprland-session.target";
  #   };
  #   Install = {
  #     WantedBy = [
  #       "hyprland-session.target"
  #     ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.kanshi}/bin/kanshi";
  #     Restart = "always";
  #     RestartSec = 5;
  #     Environment = "DISPLAY=:0";
  #     Environment = "XDG_RUNTIME_DIR=/run/user/%U";
  #   };
  # };
#   services.kanshi = {
#     enable = true;
#     systemdTarget = "hyprland-session.target";
#     settings = [
#       {
#         output.criteria = "eDP-1";
#         output.mode = "1920x1080@60.01";
#         output.scale = 1.0;
#         output.position = "0,0";
#       }
#       {
#         output.criteria = "Lenovo Group Limited LEN S28u-10 VNA4XG6D";
#         output.mode = "3840x2160@60.0";
#         output.scale = 1.5;
#         output.position = "1920,0";
#       }
#       {
#         output.criteria = "Lenovo Group Limited LEN S28u-10 VNA4XG5L";
#         output.mode = "3840x2160@60.0";
#         output.scale = 1.5;
#         output.position = "4480,0";
#       }
#       {
#         profile.name = "solo";
#         profile.outputs = [
#           {
#             criteria = "eDP-1";
#             status = "enable";
#           }
#         ];
#       }
#       {
#         profile.name = "home1";
#         profile.outputs = [
#           {
#             criteria = "eDP-1";
#             status = "disable";
#           }
#           {
#             criteria = "Lenovo Group Limited LEN S28u-10 VNA4XG6D";
#             status = "enable";
#           }
#         ];
#       }
#       {
#         profile.name = "home2";
#         profile.outputs = [
#           {
#             criteria = "eDP-1";
#             status = "disable";
#           }
#           {
#             criteria = "Lenovo Group Limited LEN S28u-10 VNA4XG5L";
#             status = "enable";
#           }
#         ];
#       }
#       {
#         profile.name = "home3";
#         profile.outputs = [
#           {
#             criteria = "eDP-1";
#             status = "disable";
#           }
#           {
#             criteria = "Lenovo Group Limited LEN S28u-10 VNA4XG5L";
#             status = "enable";
#           }
#           {
#             criteria = "Lenovo Group Limited LEN S28u-10 VNA4XG6D";
#             status = "enable";
#           }
#         ];
#       }
#     ];
#   };

  #services.flameshot = {
  #  enable = true;
  #};

  systemd.user.services.blueman-applet-hyprland = {
    Unit = {
      Description = "Start the blueman applet in Hyprland";
      Requires = [ "tray.target" ];
      After = [ "hyprland-session-pre.target" "tray.target" ];
      PartOf = [ "hyprland-session.target" ];
    };
    Install = {
      WantedBy = [ 
        "hyprland-session.target" 
      ];
    };
    Service = {
      ExecStart = "${pkgs.blueman}/bin/blueman-applet";
    };
  };

  # systemd.user.services.kwallet-pam-hyprland = {
  #   Unit = {
  #     Description = "Unlock kwallet from pam credentials for Hyprland session";
  #     Before = "network-pre.target";
  #     Wants = "network-pre.target";
  #   };
  #   Install = {
  #     WantedBy = [ 
  #       "hyprland-session.target" 
  #     ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
  #     Type = "simple";
  #     Slice = "background.slice";
  #     Restart = "no";
  #   };
  # };

  programs.wofi.enable = true;
  programs.wofi.style = ''
    * {
      font-family: ComicShannsMono Nerd Font, sans-serif;
      font-size: 16px;
    }
    
    window {
      background-color: #313244;
      border: 1px solid #89b4fa;
      color: #89b4fa;
    }
    
    #outer-box {
      border-radius: 10px;
    }

    #input {
      background: 6c7086;
      color: #89b4fa;
    }
  '';
#  programs.wofi.settings = {};

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common = {
        default = [
          "kde"
        ];
      };
      hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };
  };
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  wayland.windowManager.hyprland.systemd.enable = true;
  wayland.windowManager.hyprland.settings = {
    env = [
      # these two environment variables make sure that QT applications are styled:
      "QT_STYLE_OVERRIDE,kvantum"
      "XDG_MENU_PREFIX,plasma-"
    ];
    general = {
      resize_on_border = true;
      gaps_out = [5 10 5 10];
      gaps_in = 5;
    };
    cursor = {
      enable_hyprcursor = true;
    };
    decoration = {
      inactive_opacity = .95;

      blur = {
        enabled = true;
        size = 8;
        passes = 1;
        ignore_opacity=true;
        new_optimizations=true;
      };
    };
    misc = {
      force_default_wallpaper = 0;
    };
    input = {
      kb_layout = "de, de";
      kb_variant = "neo,";
    };
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    exec-once = [
      "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init"
      "$terminal"
      # "${pkgs.hyprpanel}/bin/hyprpanel"
      "nm-applet --indicator"
    ];
   #  monitor = [
   #    "eDP-1, 1920x1080@60, 0x0, 1"
   #    "desc:Lenovo Group Limited LEN S28u-10 VNA4XG6D, 3840x2160@60, 1920x0, 1.5"
   #    "desc:Lenovo Group Limited LEN S28u-10 VNA4XG5L, 3840x2160@60, 4480x0, 1.5, mirror, desc:Lenovo Group Limited LEN S28u-10 VNA4XG6D"
   #  ];
    bindm = [
      # mod + LMB = move window
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.25 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

      # CTRL + ALT + L (as printed on keyboard) -- *L*ock screen
      "CTRL ALT, code:46, exec, hyprlock --immediate"

      # SUPER + SPACE -- switch keyboard layout
      "$mod, code:69, exec, hyprctl switchxkblayout all next"
      # SUPER + Q (as printed on keyboard) -- *Q*uit current app
      "$mod, code:24, killactive, "
      # SUPER + T (as printed on keyboard) -- *T*erminal
      "$mod, code:28, exec, kitty"
      # SUPER + F (as printed on keyboard) -- toggle *F*loating mode
      "$mod, code:41, togglefloating,"
      # SUPER + A (as printed on keyboard) -- run *A*pplication
      "$mod, code:38, exec, wofi --show drun"

      # SUPER + P (as printed on keyboard) -- toggle *P*seudo mode
      "$mod, code:33, pseudo,"

      # SUPER + G -- *G*rab rogue windows
      # "$mod, code:31, split:grabroguewindows"
      # SUPER + H 
      "$mod, code:43, movefocus, l"
      # SUPER + L
      "$mod, code:46, movefocus, r"
      # SUPER + K
      "$mod, code:45, movefocus, u"
      # SUPER + J 
      "$mod, code:44, movefocus, d"

      "$mod SHIFT, code:57, swapnext"
      "$mod SHIFT, code:33, swapnext, prev"

      "$mod SHIFT, code:58, tagwindow, swapmark"

      "$mod CTRL, code:43, layoutmsg, preselect l"
      "$mod CTRL, code:46, layoutmsg, preselect r"
      "$mod CTRL, code:45, layoutmsg, preselect u"
      "$mod CTRL, code:44, layoutmsg, preselect d"

      ", PRINT, exec, hyprshot -m active -m output"
      "$mod, PRINT, exec, hyprshot --clipboard-only -m active -m output"
      "SHIFT, PRINT, exec, hyprshot --raw -m active -m output - | swappy -f -"
      "ALT, PRINT, exec, hyprshot --clipboard-only -m region"
      "ALT SHIFT, PRINT, exec, hyprshot --raw -m region - | swappy -f -"

      # OBS studio - pass through of recording buttons (Y/X printed on German Keyboard)
      "CTRL SHIFT, code:52, pass, ^(com\.obsproject\.Studio)$"
      "CTRL SHIFT, code:53, pass, ^(com\.obsproject\.Studio)$"
    ];
    windowrulev2 = [
      "bordercolor rgb(f5e0dc) rgb(f38ba8), tag:swapmark"
      "bordersize 5, tag:swapmark"
      "float, class:(GLWindow.*)"
      "float, class:(\.blueman-manager.*)"
      "float, title:(Volume Control.*)"
      "float, class:(org\.freedesktop\.impl\.portal\..*)"
      "float, class:(\.protonvpn-app-wrapped.*)"
      "size 400 700, class:(\.protonvpn-app-wrapped.*)"
      "size 300 350, class:(\.blueman-manager.*)"
    ];
    plugin = {
      # split-monitor-workspaces = {
      #  count = 4;
      #   enable_notifications = true;
      # };
      hyprsplit = {
        num_workspaces = 4;
        persistent_workspaces = true;
      };
      hyprbars = {
        bar_height = 20;
        bar_color = "rgb(181825)";
        hyprbars-button = [
          "rgb(f38ba8), 15, 󰖭, hyprctl dispatch killactive"
          "rgb(a6e3a1), 15, , hyprctl dispatch fullscreen 1"
          "rgb(89b4fa), 15, 🛸, hyprctl dispatch togglefloating"
          "rgb(f9e2af), 15, , hyprctl dispatch pin"
        ];
      };
      borders-plus-plus = {
        add_borders = 1;
        border_size_1 = 15;
        col.border_1 = "rgb(a6e3a1)";
      };
    };
  };
  wayland.windowManager.hyprland. extraConfig = ''
    xwayland {
      force_zero_scaling = true
    }
    bind = $mod ALT, ALT_L, submap, movePages

    submap = movePages
    bind = , code:44, workspace, m~1
    bind = , code:45, workspace, m~2
    bind = , code:46, workspace, m~3
    bind = , code:47, workspace, m~4
    bind = $mod, code:44, movetoworkspace, m~1
    bind = $mod, code:45, movetoworkspace, m~2
    bind = $mod, code:46, movetoworkspace, m~3
    bind = $mod, code:47, movetoworkspace, m~4

    bind = , code:43, togglespecialworkspace, magic
    bind = $mod, code:43, movetoworkspace, special:magic

    bind = $mod ALT, ALT_L, submap, reset

    submap = reset
  '';
  wayland.windowManager.hyprland.plugins = (with inputs.hyprland-plugins.packages.${pkgs.system}; [
    hyprbars
    borders-plus-plus
  ]) ++ [
    #inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
  ];
}
