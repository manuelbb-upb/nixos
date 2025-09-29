# NixOS configuration

This is more of an evolving backup than anything stable.
Used for work and private machine both.
Flake-based.
SDDM + KDE + Hyprland.
Most things managed with home-manager.

```
sudo nixos-rebuild swith --flake /etc/nixos/manuel-p14sg5 --impure
```

At the moment, `nixos-rebuild switch` needs the `--impure` flag, because I timestamp home-manager backup files.

I should really try to move to `nixos-tidy` soon.
