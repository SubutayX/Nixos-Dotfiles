{ pkgs, ... }:

{
  imports = [
    #./Hyprland/hyprland-config.nix  # Hazır olan config dosyan
    #./Hyprland/waybar.nix
  ];

  home.username = "sentinel";
  home.homeDirectory = "/home/sentinel";

  home.packages = with pkgs; [
    eza
    bat
    zoxide
    #btop
    fastfetch
    kitty
     
  ];

  home.stateVersion = "24.11"; 
  programs.home-manager.enable = true;
}
