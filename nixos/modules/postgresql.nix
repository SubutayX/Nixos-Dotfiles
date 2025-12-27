{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;

    ensureDatabases = [
      "sentinel"
      "sentinel_db"
      "sentinel_test"
    ];

    ensureUsers = [
      {
        name = "sentinel";
        ensureDBOwnership = true;
      }
    ];

    authentication = pkgs.lib.mkForce ''
  # Local connections
  local   all             postgres                                trust
  local   all             sentinel                                trust

  # IPv4 local connections
  host    all             postgres        127.0.0.1/32            scram-sha-256
  host    all             sentinel        127.0.0.1/32            scram-sha-256

  # IPv6 local connections
  host    all             postgres        ::1/128                 scram-sha-256
  host    all             sentinel        ::1/128                 scram-sha-256
'';

 # ⬇️ YETKİLER BURADA VERİLİR (DOĞRU YER)
    initialScript = pkgs.writeText "init.sql" ''
      ALTER ROLE sentinel WITH
        SUPERUSER
        CREATEDB
        CREATEROLE;
    '';
  };


   
}
 