# inspired by https://github.com/WhittlesJr/nixos-shared/blob/master/media.nix
{ lib, config, pkgs, ... }:
with lib;
let
  openaudible =
    let
      pname = "openaudible";
      version = "4.6.8";
      description = "A cross-platform desktop application for downloading and managing your Audible audiobooks.";

      desktopItem = pkgs.makeDesktopItem {
        name = "OpenAudible";
        exec = pname;
        icon = "OpenAudible";
        comment = description;
        desktopName = "OpenAudible";
        genericName = "Audible content downloader";
        categories = [ "AudioVideo" "Audio" ];
      };

      src = pkgs.fetchurl {
        url = "https://github.com/openaudible/openaudible/releases/download/v${version}/OpenAudible_${version}_x86_64.AppImage";
        hash = "sha256-ak2tqanIeEpkHAl9VIqL+z9/3lOWkq0elDnUy+5SqHE=";
      };
      
      appimageContents = pkgs.appimageTools.extract {
        inherit pname src version;
      };
      
    in
      pkgs.appimageTools.wrapType1 rec {
        inherit pname src version;
        extraPkgs = pkgs: with pkgs; [ webkitgtk_4_1 glib-networking ];
        profile = ''
          export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules/"
        '';
        extraInstallCommands = ''
          mkdir -p $out/share/applications
          cp ${desktopItem}/share/applications/* $out/share/applications
          #cp -r ${appimageContents}/usr/share/icons/ $out/share/
        '';

        meta = with lib; {
          description = description;
          homepage = "https://openaudible.org/";
          license = with licenses; [ asl20 ];
          maintainers = with maintainers; [ WhittlesJr ];
          platforms = [ "x86_64-linux" ];
        };
      };
in
  {
    home.packages = [ openaudible ];
    /*
  options.my = {
    role.mediaArchival = mkEnableOption "Managing and archiving A/V media";
  };
  config = mkIf config.my.role.mediaArchival {
    environment.systemPackages = with pkgs; [
      vlc                      # Vido + audio playing
      audacity                 # Audio recording and editing
      makemkv                  # Blu-ray / DVD ripping
      ccextractor              # For makemkv
      mkvtoolnix
      filebot                  # Auto-renaming movie & TV files
      whipper
      asunder                  # CD  ripping
      streamrip                # Download from Qobuz
      picard                   # Music library management
      handbrake                # Video compression
      android-file-transfer

      #openaudible
      (appimage-run.override {
        extraPkgs = pkgs: [ pkgs.libthai ];
      })
      audible-cli
    ];

    # Adds blu-ray support to VLC
    #nixpkgs.overlays = [
    #  (
    #    self: super: {
    #      libbluray = super.libbluray.override {
    #        withAACS = true;
    #        withBDplus = true;
    #      };
    #    }
    #  )
    #];
  };*/
}
