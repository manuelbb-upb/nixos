{...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = true;
      preload = [
        "/etc/nixos/wallpapers/Wassily_Kandinsky_Composition_VIII.jpg"
      ];
      wallpaper = [
        ", /etc/nixos/wallpapers/Wassily_Kandinsky_Composition_VIII.jpg"
      ];
    };
  };
}

