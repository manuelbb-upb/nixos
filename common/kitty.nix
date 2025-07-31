{
  pkgs
  ,...
}:
{
  stylix.targets.kitty.enable = true;
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    # font settings currently are managed by `stylix`
    # these are the old settings:
    # font = {
    #   name = "ComicShannsMono Nerd Font";
    #   package = pkgs.nerdfonts;
    # };
    extraConfig = builtins.readFile ./kitty.conf;
  };
}
