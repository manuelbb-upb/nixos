{pkgs, ...} :
{
  services.hypridle.enable = false;
  # disabling for now, i dont want it in Plasma, my current main DE,
  # see https://github.com/NixOS/nixpkgs/pull/355416
  services.hypridle.settings = {
    general =  {
      lock_cmd = "pidof hyprlock || hyprlock --immediate"; 
      #before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
      before_sleep_cmd = "pidof hyprlock || hyprlock --immediate"; 
      after_sleep_cmd = "hyprctl dispatch dpms on";  # to having to press a key twice to turn on the display.
      ignore_dbus_inhibit = false;
      ignore_systemd_inhibit = false;
    };

    listener = [
      {
        timeout = 150;                                # 2.5min.
        on-timeout = "brightnessctl -s set 10";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = "brightnessctl -r";                 # monitor backlight restore.
      }

      # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
      { 
        timeout = 150;                                          # 2.5min.
        on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
        on-resume = "brightnessctl -rd rgb:kbd_backlight";        # turn on keyboard backlight.
      }

      {
        timeout = 300;                                  # 5min
        on-timeout = "loginctl lock-session";           # lock screen when timeout has passed
      }

      {
        timeout = 330;                                 # 5.5min
        on-timeout = "hyprctl dispatch dpms off";        # screen off when timeout has passed
        on-resume = "hyprctl dispatch dpms on";          # screen on when activity is detected after timeout has fired.
      }

      {
        timeout = 1800;                                # 30min
        on-timeout = "systemctl suspend";                # suspend pc
      }
    ];
  };
}
