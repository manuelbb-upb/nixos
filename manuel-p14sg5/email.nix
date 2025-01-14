{pkgs, ...}:
{
  programs.thunderbird.profiles.work.isDefault = true;
  accounts.email.accounts.tud.primary = true;
}
