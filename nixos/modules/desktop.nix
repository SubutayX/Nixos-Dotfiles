# nixos/modules/desktop.nix
# KDE Plasma 6, ekran yöneticisi, klavye, locale ve ses ayarları
{ config, pkgs, ... }:

{
  imports = [
    ./font.nix
  ];

  # ── Masaüstü Ortamı: KDE Plasma 6 ────────────────────────────────
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  # ── Ekran Yöneticisi: SDDM ────────────────────────────────────────
  services.displayManager.sddm = {
    enable = true;
    settings = {
      General = {
        Numlock = "on";  # Giriş ekranında NumLock açık başlasın
      };
    };
  };

  # ── Klavye ────────────────────────────────────────────────────────
  # X11/Wayland için Türkçe Q klavye düzeni
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
  # TTY (konsol) için Türkçe Q klavye
  console.keyMap = "trq";

  # ── Sistem Dili ve Bölgesel Ayarlar ──────────────────────────────
  # Sistem arayüzü İngilizce (menüler, mesajlar, hata çıktıları)
  i18n.defaultLocale = "en_US.UTF-8";

  # Tarih/saat, para birimi ve ölçü birimleri Türkçe formatında
  # (LC_MESSAGES tanımlı değil → defaultLocale'den miras alır → İngilizce kalır)
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT    = "tr_TR.UTF-8";
    LC_MONETARY       = "tr_TR.UTF-8";
    LC_NAME           = "tr_TR.UTF-8";
    LC_NUMERIC        = "tr_TR.UTF-8";
    LC_PAPER          = "tr_TR.UTF-8";
    LC_TELEPHONE      = "tr_TR.UTF-8";
    LC_TIME           = "tr_TR.UTF-8";
  };

  # ── Ses: PipeWire (PulseAudio uyumlu) ────────────────────────────
  services.pulseaudio.enable = false;  # PipeWire ile çakışır, kapalı kalmalı
  security.rtkit.enable = true;        # PipeWire için gerçek zamanlı öncelik
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;   # 32-bit uygulama ses desteği
    pulse.enable = true;        # PulseAudio uyumlu API
  };
}
