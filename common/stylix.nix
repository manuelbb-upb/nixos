{pkgs, config, osConfig, ...}:
{
  stylix.targets.gtk.enable = true;
  stylix.targets.kde.enable = true;
  stylix.targets.hyprland.enable = true;
  stylix.targets.kitty.enable = true;
  # due to this line, 
  # https://github.com/danth/stylix/blob/934e2bfe7954d6c94f25d45cb12a8b3547825699/stylix/home-manager-integration.nix#L34
  # changing wallpaper changes color scheme; let's copy it ourselves
  stylix.base16Scheme = osConfig.stylix.base16Scheme;
  stylix.fonts = {
    monospace = {
      name = "ComicShannsMono Nerd Font";
      package = pkgs.nerd-fonts.comic-shanns-mono;
    };
  };
  #stylix.fonts.serif = config.stylix.fonts.monospace;
  #stylix.fonts.sansSerif = config.stylix.fonts.monospace;
}
