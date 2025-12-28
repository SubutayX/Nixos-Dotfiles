{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pciutils
    mesa-demos

    waybar
    wofi
    kitty
    dunst
    grim
    slurp
    wl-clipboard
    hyprpaper
  ];
}
