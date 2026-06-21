# nixos/modules/nvidia.nix
# NVIDIA RTX 4050 (Ada Lovelace — sm_89) için optimize edilmiş yapılandırma
{ config, lib, pkgs, ... }:

{
  # ── Donanım hızlandırma (32-bit oyun/uygulama desteği dahil) ──────
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Steam ve Wine için gerekli
  };

  # ── NVIDIA sürücüsünü X11 ve Wayland için etkinleştir ─────────────
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting: Wayland ve modern X11 için zorunlu
    modesetting.enable = true;

    # Açık kaynak kernel modülü:
    # RTX 40 serisi (Ada Lovelace) için sürücü 560+ ile "open = true" ÖNERİLİR.
    # Sorun yaşarsan false yap.
    open = true;

    # Güç yönetimi: Suspend/resume kararlılığı için aktif et
    powerManagement.enable = true;
    # Fine-grained: Sadece Optimus (hibrit) laptop kurulumlarında gerekli
    powerManagement.finegrained = false;

    # nvidia-settings GUI paneli
    nvidiaSettings = true;

    # Sürücü: stable (RTX 40 serisi için önerilen)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ── Wayland + NVIDIA ortam değişkenleri ───────────────────────────
  environment.sessionVariables = {
    # NVIDIA GBM backend (Wayland için)
    GBM_BACKEND        = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # VA-API donanım video kodu çözme (Firefox, Chrome, Haruna vb.)
    LIBVA_DRIVER_NAME  = "nvidia";
    NVD_BACKEND        = "direct";

    # Electron tabanlı uygulamaları (vscode, discord vb.) Wayland'de çalıştır
    NIXOS_OZONE_WL     = "1";
  };

  # ── NVIDIA kernel modül parametreleri ────────────────────────────
  boot.extraModprobeConfig = ''
    # DRM kernel mode setting — Wayland için zorunlu
    options nvidia-drm modeset=1 fbdev=1
  '';
}
