{ pkgs, ... } :
{
  home.packages = with pkgs; [
  ];

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix		    # understand nix files
      vim-airline	    # bottom status bar
      vim-wayland-clipboard # copy to clipboard
      vim-lastplace         # open files at last position
      #vim-fugitive
    ];
    extraConfig = ''
      filetype plugin indent on
      filetype indent on
      set mouse=a
      set clipboard=unnamedplus,unnamed
      cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!
      cmap x!! w!! <bar> q
    '';
  };
}
