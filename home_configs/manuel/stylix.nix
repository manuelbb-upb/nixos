{pkgs, config, ...}:
{
  stylix.targets.gtk.enable = true;
#  stylix.targets.kde.enable = true;
  stylix.targets.hyprland.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.fonts = {
    monospace = {
      name = "ComicShannsMono Nerd Font";
      package = pkgs.nerdfonts;
    };
  };
  #stylix.fonts.serif = config.stylix.fonts.monospace;
  #stylix.fonts.sansSerif = config.stylix.fonts.monospace;
}
