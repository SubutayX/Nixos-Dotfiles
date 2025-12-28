{ config, pkgs, ... }:

{
  # Home Manager tarafında Hyprland yapılandırması
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };

  # Kullanıcıya Özel Ortam Değişkenleri
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  # Config dosyasını bağlama
  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };
}