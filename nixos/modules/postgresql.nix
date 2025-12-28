{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.lib.mkForce pkgs.postgresql_18;

    ensureUsers = [
      {
        name = "sentinel";
        ensureDBOwnership = true;
        ensureClauses = {
          superuser = true;
          createdb = true;
          createrole = true;
          login = true;
          replication = true;
          bypassrls = true;
        };
      }
    ];

    ensureDatabases = [
      "sentinel"
      "DB_Forum"
      "DB_Forum_test"
    ];

    # GÜNCELLENEN KISIM:
    # 'trust' -> Şifre sormaz (Güvensiz ama kolay)
    # 'scram-sha-256' -> Şifre sorar (Güvenli)
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  address       auth-method
      
      # "local" bağlantılar (terminalden psql yazınca) genelde peer veya trust kalabilir
      # ama şifre sorsun istiyorsanız burayı da scram-sha-256 yapabilirsiniz.
      local all       all                   trust

      # TCP/IP bağlantıları (DBeaver, TablePlus, Kodunuz vb.) için ŞİFRE ZORUNLU OLSUN:
      host  all       all     127.0.0.1/32  scram-sha-256
      host  all       all     ::1/128       scram-sha-256
    '';
  };

  environment.systemPackages = with pkgs; [
    postgresql_18
  ];
}