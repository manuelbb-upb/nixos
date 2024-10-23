# https://gitlab.com/usmcamp0811/dotfiles/-/blob/fb584a888680ff909319efdcbf33d863d0c00eaa/modules/home/apps/firefox/default.nix
{pkgs, inputs, ...}:
let
  addons = pkgs.nur.repos.rycee.firefox-addons;
in
{
  home.packages = [
    pkgs.vdhcoapp
  ];
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://duckduckgo.com";
          "browser.search.defaultenginename" = "DuckDuckGo";
        };
        extraConfig = ''
          user_pref("extensions.autoDisableScopes", 0);
          user_pref("extensions.enabledScopes", 15);
        '';
        extensions = with addons; [
          firefox-color
          bitwarden
          ublock-origin
          video-downloadhelper
        ];
        bookmarks = [
          {
            name = "Bookmarks Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "TUD UniMail";
                url = "https://webmail.tu-dortmund.de";
              }
              {
                name = "FC Theme";
                url = "https://color.firefox.com/?theme=XQAAAAJDBAAAAAAAAABBqYhm849SCicxcUcPX38oKRicm6da8pFtMcajvXaAE3RJ0F_F447xQs-L1kFlGgDKq4IIvWciiy4upusW7OvXIRinrLrwLvjXB37kvhN5ElayHo02fx3o8RrDShIhRpNiQMOdww5V2sCMLAfehho7r-AtSBPnvx4uvv7vRnzG2zBiFpesm1SAl1KsPscTY8iQYgDnBUvUwxRg5oKKrqaQ_z3v5Hws-8hk4Kc3t_NXn8IoY4ZYVdc86z2QRba2CmsdOmEA-8eHxrfsyZHFWrEEdKZyHYvxjqukUFLs50Fy6pCfDvrjyNBjAtl1dnf9Nj5Jm0ul9fPQvmPAMvweio7eiPSwgqK0N4okhCeWhmc0VioXa6KngF81ywVKwm6ZuPBvP1fLlkT3IQ2e3Psy08_qy2cz2cV67Je242GGYfnOaLZl36LyWV0_AUCtjW19KlUsTGIMGopDMEWZDYstyLga9H5O6w7Q58QVg7y2k7-oNLsIMr3nPFiMjZeJGYJZ9dd4PzYa90eT6KAqaGs50nZXt6xwOFEcYsIJjRbn__m_9iA";
              }
              {
                name = "Flakes";
                url = "https://github.com/the-nix-way/dev-templates";
              }
            ];
          }
        ];
      };
    };
  };
}
