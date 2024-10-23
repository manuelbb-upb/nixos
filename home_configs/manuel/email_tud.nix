{pkgs, ...}:
{
  programs.thunderbird = {
    enable = true;
    profiles = {
      work = {
        isDefault = true;
      };
    };
  };
  accounts.email = {
    accounts.tud = {
      address = "manuel.berkemeier@tu-dortmund.de";
      userName = "mmanberk";
      realName = "Manuel Berkemeier";
      primary = true;
      signature.text = ''
        Manuel Berkemeier
        (er – ihm – sein  / he – him – his)

        Wissenschaflticher Mitarbeiter / Scientific Staff Member 

        Technische Universität Dortmund / Dortmund University
        Informatik / Computer Science
        Joseph-von-Fraunhofer-Straße 25
        44227 Dortmund

        manuel.berkemeier@tu-dortmund.de
        www.tu-dortmund.de
      '';
      imap = {
        host = "outlook.tu-dortmund.de";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "outlook.tu-dortmund.de";
        port = 587;
        tls.enable = true;
        tls.useStartTls = true;
      };

      thunderbird = {
        enable = true;
        profiles = [
          "work"
        ];
      };
    };
  };
}
