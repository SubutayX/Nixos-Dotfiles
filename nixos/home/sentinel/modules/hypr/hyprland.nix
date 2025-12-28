{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

 home.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  WLR_NO_HARDWARE_CURSORS = "1";
};

 xdg.configFile."hypr/hyprland.conf" = {
  source = ./hyprland.conf;
};
}
