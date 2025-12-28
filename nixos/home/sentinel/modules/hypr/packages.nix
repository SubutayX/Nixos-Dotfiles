{ config, pkgs, ... }:

{
   home.packages = with pkgs; [
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
