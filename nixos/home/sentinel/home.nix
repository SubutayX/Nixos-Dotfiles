{ pkgs, ... }:

{
  imports = [
    ./modules/hypr/default.nix
  ];

  home.username = "sentinel";
  home.homeDirectory = "/home/sentinel";

  home.packages = with pkgs; [
    eza
    bat
    zoxide
    fastfetch
    kitty
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
