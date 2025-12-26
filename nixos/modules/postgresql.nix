{ config, pkgs, ... }:

{
  services.postgresql = {
  enable = true;
  package = pkgs.postgresql_17;

  ensureDatabases = [
    "sentinel"
    "sentinel_db"
    "sentinel_test"
  ];

  ensureUsers = [
    {
      name = "sentinel";
      ensureDBOwnership = true;
      attributes = {
        login = true;
        superuser = false;
        createdb = false;
        createrole = false;
      };
    }
  ];

  authentication = pkgs.lib.mkForce ''
    local   all   sentinel            trust
    host    all   sentinel   127.0.0.1/32   scram-sha-256
    host    all   sentinel   ::1/128        scram-sha-256
  '';
};

}
