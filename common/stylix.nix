{pkgs, config, osConfig, ...}:
{
  stylix.targets.gtk.enable = true;
  stylix.targets.kde.enable = true;
  # due to this line, 
  # https://github.com/danth/stylix/blob/934e2bfe7954d6c94f25d45cb12a8b3547825699/stylix/home-manager-integration.nix#L34
  # changing wallpaper changes color scheme; let's copy it ourselves
  stylix.base16Scheme = osConfig.stylix.base16Scheme;
}
