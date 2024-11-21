{
  pkgs
  ,...
}:
{
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
    extraConfig = ''
      enabled_layouts grid, *
      clear_all_shortcuts yes

      # restore some defaults
      map kitty_mod+c copy_to_clipboard
      map kitty_mod+v paste_from_clipboard

      map kitty_mod+f1 show_kitty_doc overview
      map kitty_mod+f2 edit_config_file
      map kitty_mod+f5 load_config_file
      map kitty_mod+f7 focus_visible_window

      # ctrl shift w(new) t(key) -- *t*oggle layout
      map kitty_mod+0x77 next_layout

      # ctrl shift i(neo) s(key) -- show *s*crollback
      map kitty_mod+0x69 show_scrollback

      # ctrl shift b(neo) n(key) -- *n*ew tab
      map kitty_mod+0x62 new_tab_with_cwd
      # ctrl shift x(neo) q(key) -- *q*uit 
      map kitty_mod+0x78 close_tab

      # ctrl shift enter -- default
      map kitty_mod+enter new_window
      # ctrl shift e(neo) f(key) -- open new *F*enster
      map kitty_mod+0x65 launch --cwd=current

      # ctrl alt s(neo) h(key) -- vim navigation left
      map ctrl+alt+0x73 previous_window
      # ctrl alt t(neo) l(key) -- vim navigation right
      map ctrl+alt+0x74 next_window

      # ctrl shift s(neo) h(key) -- vim navigation left
      map kitty_mod+0x73 previous_tab
      # ctrl shift t(neo) l(key) -- vim navigation right
      map kitty_mod+0x74 next_tab

      # ctrl shift h(neo) u(key) -- *u*ndo font size changes
      map kitty_mod+0x68 change_font_size all 0
      # ctrl shift g(neo) i(key) -- *i*ncrease size
      map kitty_mod+0x67 change_font_size all +2.0
      # ctrl shift f(neo) o(key) -- zoom *o*ut
      map kitty_mod+0x66 change_font_size all -2.0
    '';
  };
}
