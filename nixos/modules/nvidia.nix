{ config, lib, pkgs, ... }:

{
  # Kapalı kaynak sürücülere izin ver
  nixpkgs.config.allowUnfree = true;

  # Grafik sürücülerini etkinleştir
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # X11 ve Wayland için NVIDIA sürücüsünü yükle
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modsetting gereklidir
    modesetting.enable = true;

    # Güç yönetimi (opsiyonel, uyku modunda sorun yaşarsanız açın)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Açık kaynak kernel modülünü kullanma (RTX 20 serisi ve sonrası için önerilir)
    # Eğer eski bir kartınız varsa bunu false yapın
    open = false;

    # NVIDIA ayarlar panelini etkinleştirir (nvidia-settings)
    nvidiaSettings = true;

    # Kullanılacak sürücü paketini seçin (genelde stable en iyisidir)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
