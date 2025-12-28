{ pkgs, ... }:

{
  # Hyprland'i aktif et
  programs.hyprland = {
    enable = true;
    # Ekran paylaşımı vb. için XWayland desteği
    xwayland.enable = true;
  };

  # Hyprland için gerekli çevresel değişkenler
  environment.sessionVariables = {
    # Eğer NVIDIA ekran kartınız varsa bunu eklemelisiniz:
    # WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1"; # Electron uygulamalarının (Discord, VSCode) Wayland'de düzgün çalışması için
  };

  # Hyprland için yardımcı araçlar
  environment.systemPackages = with pkgs; [
    waybar           # Durum çubuğu
    dunst            # Bildirim sistemi
    libnotify        # Bildirim kütüphanesi
    swww             # Duvar kağıdı aracı
#    kitty            # Terminal (Hyprland varsayılanı)
    rofi     # Uygulama başlatıcı
  ];
}
