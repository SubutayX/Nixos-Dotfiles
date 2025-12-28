{ config, pkgs, ... }:

{
  # 1. Hyprland'i Sistem Genelinde Etkinleştir
  programs.hyprland.enable = true;

  # 2. XServer ve SDDM (Giriş Ekranı) Ayarları
  services.xserver.enable = true;
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # Tema ayarlarınız varsa buraya ekleyebilirsiniz
  };

  # 3. XDG Portal (Ekran paylaşımı ve pencereler arası iletişim için şart)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  
  # Güvenlik için (Hyprland kilit ekranı vb. için gerekli olabilir)
  security.pam.services.sddm.enableGnomeKeyring = true;
}