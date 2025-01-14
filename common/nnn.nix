{pkgs, ...}:
{
  programs.nnn.enable = true;
  home.file.".config/zsh-custom-funcs/quitcd".source = ./quitcd.bash_sh_zsh;
  programs.zsh.initExtra = "source $HOME/.config/zsh-custom-funcs/quitcd";
}
