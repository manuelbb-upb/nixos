{pkgs, ...}:
{

  programs.zsh = {
    enable = true;
    initContent = ''
      # Check if the directory exists and is indeed a directory
      if [[ -d "$HOME/.config/zsh-custom-funcs" ]]; then
        fpath+=("$HOME/.config/zsh-custom-funcs")
      fi
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
      extraConfig = ''
        zstyle :omz:plugins:ssh-agent agent-forwarding yes
      '';
    };
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "catppuccin_mocha";
  };
}
