{pkgs, ...}:
{

  home.file.".config/zsh-custom-funcs/dunst_pause".source = ./zsh_dunst_pause.sh;
  home.file.".config/zsh-custom-funcs/vimcd".source = ./zsh_vimcd.sh;
  # I am sourcing the above files. We could enable them for autoloading by name by putting
  # `fpath=($HOME/.config/zsh-custom-funcs $fpath);`
  # in the `initExtra` section.

  programs.zsh = {
    enable = true;
    initExtra = ''
      # any-nix-shell zsh --info-right | source /dev/stdin
      source $HOME/.config/zsh-custom-funcs/dunst_pause
      source $HOME/.config/zsh-custom-funcs/vimcd
    '';
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions.src;
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "ssh-agent"
      ];
    };
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "catppuccin_mocha";
  };
}
