{...}:
{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "server role" = "standalone server";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.178. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "socket options" = "TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=2048000 SO_SNDBUF=2048000";
        "use sendfile" = "yes";
        "min receivefile size" = "16384";
        "getwd cache" = "true";
      };
      "private" = {
        "path" = "/home/manuel";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
#        "create mask" = "0644";
#        "directory mask" = "0755";
#        "force user" = "smbusr";
#        "force group" = "smbgrp";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
}
