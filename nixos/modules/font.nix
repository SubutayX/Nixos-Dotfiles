# /etc/nixos/modules/desktop/fonts.nix
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Geliştirici fontları
    jetbrains-mono
    fira-code
nerd-fonts.fira-code
  nerd-fonts.jetbrains-mono
    
    # Diğer sistem fontları
    dejavu_fonts
    # ...
  ];
}
