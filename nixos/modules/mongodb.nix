# nixos/modules/mongodb.nix
# ──────────────────────────────────────────────────────────────────────────────
# MongoDB 7.x NoSQL Veritabanı yapılandırması
#
# Bağlantı bilgileri:
#   Host  : 127.0.0.1 (localhost)
#   Port  : 27017
#   Auth  : Geliştirme için devre dışı (varsayılan)
#
# ┌─ YENİ VERİTABANI EKLEMEK (2 YOL) ─────────────────────────────────────────
# │
# │  YOL 1 — NixOS yapılandırması ile (kalıcı, önerilen):
# │    Bu dosyadaki "mongodb-init-dbs" script bölümüne aşağıdaki bloğu ekle:
# │
# │      use yeni_db_adi;
# │      if (db.init.countDocuments({}) === 0) {
# │        db.init.insertOne({ created: new Date(), info: "açıklama" });
# │        print("yeni_db_adi oluşturuldu");
# │      }
# │
# │    Sonra rebuild et:
# │      sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#nixos
# │
# │  YOL 2 — Terminal ile anlık oluşturma (rebuild gerekmez):
# │      mongosh
# │      > use yeni_db_adi
# │      > db.bir_koleksiyon.insertOne({ bilgi: "ilk kayit" })
# │      > show dbs          # tüm veritabanlarını listele
# │      > exit
# │
# │  Diğer faydalı komutlar:
# │      mongosh --eval "show dbs"
# │      mongosh yeni_db --eval "show collections"
# │      mongosh yeni_db --eval "db.dropDatabase()"
# └────────────────────────────────────────────────────────────────────────────
{ config, pkgs, lib, ... }:

{
  # ── MongoDB Servisi ───────────────────────────────────────────────
  services.mongodb = {
    enable = true;

    # Paket: SSPL lisansı nedeniyle unfree gerektirir.
    # allowUnfree = true zaten system.nix'te tanımlı.
    # Sorun yaşarsan: pkgs.mongodb-6_0 veya pkgs.mongodb dene.
    package = pkgs.mongodb-7_0;

    # Güvenlik: yalnızca localhost bağlantılarına izin ver
    # Ağdan erişim için "0.0.0.0" yapılabilir (önerilmez)
    bind_ip = "127.0.0.1";
  };

  # ── MongoDB CLI Araçları ──────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    mongosh        # MongoDB Shell 2.x (mongosh komutu)
    mongodb-tools  # mongodump, mongorestore, mongostat, mongoimport, mongoexport
  ];

  # ── Başlangıç Veritabanları ───────────────────────────────────────
  # MongoDB'de veritabanları ilk belge eklendiğinde otomatik oluşur.
  # Bu oneshot servis, sistem başlangıcında 2 veritabanını hazırlar.
  systemd.services.mongodb-init-dbs = {
    description = "MongoDB başlangıç veritabanlarını oluştur";
    after       = [ "mongodb.service" ];
    wants       = [ "mongodb.service" ];
    wantedBy    = [ "multi-user.target" ];

    serviceConfig = {
      Type            = "oneshot";
      RemainAfterExit = true;
    };

    script =
      let
        initScript = ''
          // ═══════════════════════════════════════════════════════════════
          // YENİ VERİTABANI EKLEMEK:
          //   Bu bloğu kopyala → yeni db adıyla değiştir → rebuild et.
          //   VEYA anlık: mongosh > use yeni_db > db.col.insertOne({})
          // ═══════════════════════════════════════════════════════════════

          // ── Veritabanı 1: app_dev ──────────────────────────────────
          // Amaç: Aktif geliştirme sürecindeki NoSQL veritabanı.
          use app_dev;
          if (db.init.countDocuments({}) === 0) {
            db.init.insertOne({
              created : new Date(),
              info    : "Uygulama gelistirme NoSQL veritabani",
              version : 1
            });
            print("KURULUM: app_dev olusturuldu.");
          } else {
            print("KONTROL: app_dev zaten mevcut.");
          }

          // ── Veritabanı 2: app_logs ─────────────────────────────────
          // Amaç: Log, event ve audit kayıtları.
          // Serbest şemalı yapısı nedeniyle loglama için idealdir.
          use app_logs;
          if (db.init.countDocuments({}) === 0) {
            db.init.insertOne({
              created : new Date(),
              info    : "Log ve event kayitlari icin NoSQL veritabani",
              version : 1
            });
            print("KURULUM: app_logs olusturuldu.");
          } else {
            print("KONTROL: app_logs zaten mevcut.");
          }

          print("Mevcut veritabanlari:");
          show dbs;
        '';
        initFile = pkgs.writeText "mongodb-init.js" initScript;
      in
      ''
        # MongoDB'nin hazır olmasını bekle (max 30 sn)
        for i in $(seq 1 15); do
          if ${pkgs.mongosh}/bin/mongosh --quiet \
              --eval "db.runCommand({ping:1})" >/dev/null 2>&1; then
            echo "MongoDB hazir."
            break
          fi
          echo "MongoDB bekleniyor... ($i/15)"
          sleep 2
        done

        ${pkgs.mongosh}/bin/mongosh --quiet ${initFile}
      '';
  };
}
