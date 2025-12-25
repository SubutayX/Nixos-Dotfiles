{ config, pkgs, ... }:

{
  nix.settings = {
    # CPU çekirdeklerini otomatik kullan
    max-jobs = "auto";
    cores = 0;

    # Paralel indirme sayısı (EN KRİTİK AYAR)
    http-connections = 50;

    # Binary cache kullanımını garantiye al
    builders-use-substitutes = true;
    substitute = true;

    # Yavaş bağlantılarda takılmayı önler
    connect-timeout = 5;
    download-attempts = 5;
  };
}
