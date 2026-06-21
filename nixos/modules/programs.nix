# nixos/modules/programs.nix
# Günlük kullanım uygulamaları, medya, sistem araçları ve sanal makine
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # ── 🌐 Tarayıcı ───────────────────────────────────────────────────
    google-chrome

    # ── 🎵 Medya ──────────────────────────────────────────────────────
    spotify
    obs-studio            # Ekran kaydı ve yayın
    haruna                # Video oynatıcı (MPV tabanlı)
    kdePackages.gwenview  # Resim görüntüleyici

    # ── 🖥️  Terminal Emülatörleri ────────────────────────────────────
    wezterm    # GPU hızlandırmalı terminal
    alacritty  # Hafif GPU hızlandırmalı terminal
    # konsole → KDE Plasma ile birlikte otomatik gelir

    # ── 📊 Sistem İzleme & Optimizasyon ──────────────────────────────
    btop      # Kaynak izleyici (modern htop)
    htop      # Klasik süreç izleyici
    glances   # Python tabanlı sistem izleyici
    fastfetch # Sistem bilgisi görüntüleyici
    stacer    # Sistem optimizasyon aracı

    # ── 📂 Dosya Yönetimi & İndirme ──────────────────────────────────
    kdePackages.dolphin  # KDE dosya yöneticisi
    kdePackages.ark      # Arşiv yöneticisi
    aria2                # Çok protokollü indirme yöneticisi
    ventoy               # Önyüklenebilir USB oluşturucu

    # ── 🖥️  Sanal Makine (KVM/QEMU) ─────────────────────────────────
    virt-manager  # QEMU/KVM sanal makine yöneticisi
    qemu          # QEMU tam paket (qemu-full)

    # ── 🛠️  Diğer Araçlar ─────────────────────────────────────────────
    kdePackages.spectacle  # Ekran görüntüsü aracı
    pavucontrol            # PulseAudio ses yöneticisi
    libreoffice-fresh      # Ofis paketi
  ];

  # ── 🖥️  Sanal Makine servisleri (libvirt / KVM) ──────────────────
  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;   # UEFI VM desteği
    qemu.swtpm.enable = true;  # TPM emülasyonu
  };

  programs.virt-manager.enable = true;
}
