{pkgs, ...}:
{
  programs.thunderbird.profiles.private.isDefault = true;
  accounts.email.accounts.hotmail.primary = true;
}
