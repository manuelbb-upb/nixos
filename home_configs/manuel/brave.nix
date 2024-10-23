{pkgs, ...}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {
        # Catpuccin Mocha
        id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";
      }
      {
        # Bitwarden
        id = "nngceckbapebfimnlniiiahkandclblb";
      }
      {
        # UBlock Origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      {
        # Zotero Connector
        id = "ekhagklcjbdpajgpjgmbionohlpdbjgc";
      }
    ];
  };
}
