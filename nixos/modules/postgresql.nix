# nixos/modules/postgresql.nix
# ──────────────────────────────────────────────────────────────────────────────
# PostgreSQL 18 yapılandırması
#
# ┌─ YENİ VERİTABANI EKLEMEK ──────────────────────────────────────────────────
# │  1. Aşağıdaki "ensureDatabases" listesine yeni ismi ekle:
# │       "yeni_db_adi"
# │  2. Değişikliği uygula:
# │       sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#nixos
# │  NixOS bir sonraki başlatmada veritabanını otomatik oluşturur.
# │
# │  Manuel oluşturmak istersen (yeniden başlatmadan):
# │       psql -U sentinel -c "CREATE DATABASE yeni_db_adi;"
# │
# │  Varolan veritabanlarını listelemek için:
# │       psql -U sentinel -c "\l"
# └────────────────────────────────────────────────────────────────────────────
{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.lib.mkForce pkgs.postgresql_18;

    # ── Kullanıcı tanımı ────────────────────────────────────────────
    # Kullanıcı eklemek için "ensureUsers" listesine yeni blok ekle.
    # Şifre belirlemek için: psql -U sentinel -c "ALTER USER kullanici_adi PASSWORD 'sifre';"
    ensureUsers = [
      {
        name = "sentinel";
        ensureDBOwnership = true;
        ensureClauses = {
          superuser   = true;   # Tüm yetkilere sahip
          createdb    = true;   # Yeni veritabanı oluşturabilir
          createrole  = true;   # Yeni rol oluşturabilir
          login       = true;   # Giriş yapabilir
          replication = true;   # Replikasyon yapabilir
          bypassrls   = true;   # Row Level Security'yi atlar
        };
      }
    ];

    # ── Veritabanları ───────────────────────────────────────────────
    # YENİ VERİTABANI EKLEMEK: Buraya yeni isim yaz, sonra rebuild et.
    # Örnek: "yeni_projem"
    ensureDatabases = [
      "sentinel"        # Kişisel / admin veritabanı
      "dev_db"          # Aktif geliştirme veritabanı
      "test_db"         # Otomatik test / CI veritabanı
    ];

    # ── Kimlik Doğrulama (pg_hba.conf) ─────────────────────────────
    # trust        → Şifresiz erişim (sadece yerel geliştirme için uygundur)
    # scram-sha-256 → Şifreli erişim (DBeaver, uygulama bağlantıları)
    authentication = pkgs.lib.mkOverride 10 ''
      # type  database  user  address        auth-method
      #
      # Yerel bağlantılar (psql komutu ile terminal'den):
      local   all       all                  trust

      # TCP/IP bağlantıları — DBeaver, uygulama kodun, vb.:
      host    all       all   127.0.0.1/32   scram-sha-256
      host    all       all   ::1/128        scram-sha-256
    '';

    # ── Performans ayarları ────────────────────────────────────────
    settings = {
      max_connections           = 200;
      shared_buffers            = "256MB";  # RAM'in ~%25'i önerilir
      effective_cache_size      = "1GB";
      maintenance_work_mem      = "64MB";
      checkpoint_completion_target = "0.9";
      wal_buffers               = "16MB";
      default_statistics_target = 100;
      log_timezone              = "Europe/Istanbul";
      datestyle                 = "iso, mdy";
      timezone                  = "Europe/Istanbul";
    };
  };

  # postgresql_18 CLI araçları (psql, pg_dump, createdb vb.)
  environment.systemPackages = with pkgs; [
    postgresql_18
  ];
}
