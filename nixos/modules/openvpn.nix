{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openvpn
  ];

  services.openvpn.servers = {
    myvpn = {
      autoStart = true;

      config = ''
        config /etc/openvpn/myvpn.ovpn
      '';
    };
  };
}
