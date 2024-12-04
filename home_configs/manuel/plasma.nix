{pkgs, ...}:
{
  # set bookmarks 
  home.file.".local/share/user-places.xbel".source = ./plasma_dolphin_user_places.xbel;
  programs.plasma = {
    enable = true;
    kwin = {
      virtualDesktops = {
        rows = 1;
        number = 4;
        names = [
          "Pane 1"
          "Pane 2"
          "Pane 3"
          "Pane 4"
        ];
      };
      titlebarButtons = {
        left = [
          "keep-above-windows"
          "on-all-desktops"
          "more-window-actions"
        ];
        right = [
          "help"
          "minimize"
          "maximize"
          "close"
        ];
      };
    };
    shortcuts = {
      kwin = {
        "Window to Desktop 1" = "Meta+Alt+H";
        "Window to Desktop 2" = "Meta+Alt+G";
        "Window to Desktop 3" = "Meta+Alt+F";
        "Window to Desktop 4" = "Meta+Alt+Q";
        "Switch to Desktop 1" = "Meta+H";
        "Switch to Desktop 2" = "Meta+G";
        "Switch to Desktop 3" = "Meta+F";
        "Switch to Desktop 4" = "Meta+Q";
      };
      "services/org.kde.krunner.desktop"."_launch" = "Meta+U";# ["Meta+U" "Alt+F2"];
      "services/org.kde.konsole.desktop"."_launch" = "none";  # clash with kitty 
      "services/kitty.desktop"."_launch" = "Meta+W";  # "Tlike in Terminal
    };
  };
}
