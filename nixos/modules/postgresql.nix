{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17; # Kararlı en güncel sürüm
    
    # İlk kurulumda otomatik veritabanı ve kullanıcı
    ensureDatabases = ["sentinel" "sentinel_db" ];
    ensureUsers = [
      {
        name = "sentinel";
        ensureDBOwnership = true;
      }
    ];

    # DBeaver/Lokal bağlantı izinleri
    authentication = pkgs.lib.mkForce ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            scram-sha-256
      host    all             all             ::1/128                 scram-sha-256
    '';
  };
}
