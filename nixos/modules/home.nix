# nixos/modules/home.nix
# Home Manager — kullanıcı seviyesi araçlar ve ayarlar
{ pkgs, ... }:

{
  imports = [
    # ./Hyprland/hyprland-config.nix
    # ./Hyprland/waybar.nix
  ];

  home.username = "sentinel";
  home.homeDirectory = "/home/sentinel";

  home.packages = with pkgs; [
    eza   # ls alternatifi (ikonlar + git desteği)
    bat   # cat alternatifi (sözdizimi renklendirmesi)
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
