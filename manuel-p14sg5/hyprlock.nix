{pkgs, ...}:
{
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general = {
      disable_loading_bar = true;
      grace = 60;
      hide_cursor = true;
      no_fade_in = false;
    };

    background = [
      {
        color = "rgb(1e1e2e)";
        blur_passes = 3;
        blur_size = 8;
      }
    ];

    input-field = [
      {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(205, 214, 244)";
        inner_color = "rgb(108, 112, 134)";
        outer_color = "rgb(24, 24, 37)";
        outline_thickness = 5;
        shadow_passes = 2;
      }
    ];
  };
}
