{pkgs, ...}:
{
  programs.waybar.enable = true;
  programs.waybar.systemd = {
    enable = true;
    target = "hyprland-session.target";
  };
  
  programs.waybar.settings = [
    {
      name = "mainbar";
      height = 30;
      spacing = 4;
      modules-left = [
        "custom/power"
        "hyprland/workspaces"
        "hyprland/submap"
      ];
      modules-center = [
        # "hyprland/window"
        "wlr/taskbar"
      ];
      modules-right = [
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "power-profiles-daemon"
        "cpu"
        "memory"
        "temperature"
        "keyboard-state"
        "battery"
        "clock"
        "tray"
      ];

      "custom/power" = {
        format = "⏻ ";
        tooltip = false;
        menu = "on-click";
        menu-file = "$HOME/.config/waybar/power_menu.xml";
        menu-actions = {
          shutdown =  "shutdown";
          logout = "hyprctl dispatch exit";
          reboot = "reboot";
          suspend =  "systemctl suspend";
          hibernate = "systemctl hibernate";
        };
      };

      "hyprland/workspaces" = {
        on-click = "activate";
        show-special = true;
        format = "{id}{icon}";
        format-icons = {
          default = "";
          special = "";
        };
      };
     
      "hyprland/submap" = {
        format = "<span color='#a6da95'>Mode:</span> {}";
        tooltip = false;
      };


      "wlr/taskbar" = {
        format = "{icon}";
        all-outputs = false;
        #icon-size = 14;
	icon-theme = "Numix-Circle";
	tooltip-format = "{title}";
	on-click = "activate";
	ignore-list = [
          # List of app_id/titles to be invisible
	];
	rewrite = {
	  "Firefox Web Browser" = "Firefox";
	};
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons =  {
          activated = "";
          deactivated = "";
        };
      };

      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
        };
        on-click = "pavucontrol-qt";
      };

      network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
      };

      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = {
          format = "{}% ";
      };
      temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
      };
      keyboard-state = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };
    
      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = ["" "" "" "" ""];
      };
      tray = {
        spacing = 10;
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%d-%m-%Y}";
      };
    }
  ];

  programs.waybar.style = (builtins.readFile ./waybar.css);
  
  home.file.".config/waybar/power_menu.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <interface>
      <object class="GtkMenu" id="menu">
        <child>
          <object class="GtkMenuItem" id="suspend">
            <property name="label">Suspend</property>
          </object>
        </child>
         <child>
          <object class="GtkMenuItem" id="logout">
            <property name="label">Logout</property>
          </object>
        </child>
        <child>
          <object class="GtkMenuItem" id="hibernate">
            <property name="label">Hibernate</property>
          </object>
        </child>
        <child>
          <object class="GtkMenuItem" id="shutdown">
            <property name="label">Shutdown</property>
          </object>
        </child>
        <child>
          <object class="GtkSeparatorMenuItem" id="delimiter1"/>
        </child>
        <child>
          <object class="GtkMenuItem" id="reboot">
            <property name="label">Reboot</property>
            </object>
        </child>
      </object>
    </interface>
  '';
}
