{pkgs, ...}:
{
  programs.nnn = {
    enable = true;
    extraPackages = with pkgs; [
      ffmpeg
      ffmpegthumbnailer
      imagemagick
    ];
    plugins.mappings = {
      p = "preview-tui";
    };
  };

  home.sessionVariables = {
    NNN_FIFO="/tmp/nnn.fifo";
    NNN_TERMINAL="kitty";
  };

  home.file.".config/zsh-custom-funcs/n".source = ../scripts/n.zsh;
  programs.zsh.initExtra = "autoload -Uz n";
}
