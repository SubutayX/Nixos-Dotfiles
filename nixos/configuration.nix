{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/system.nix
    ./modules/users.nix
    ./modules/desktop.nix

    # Geliştirme ortamı (diller, araçlar, IDE'ler, konteynerler)
    ./modules/development.nix
    ./modules/programs.nix

    ./modules/nvidia.nix
    ./modules/postgresql.nix
    ./modules/starship.nix
    # ./modules/hyprland.nix
    ./modules/nix-parallel-downloads.nix
  ];

  ## Flake + Nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sentinel = import ./modules/home.nix;

  ## Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # Sistem açılışında Bluetooth'u otomatik aç
    settings = {
      Policy = {
        AutoEnable = true;
      };
    };
  };
  # btusb modülü için autosuspend'i kapat (bağlantı kopması sorununu önler)
  # NOT: boot.kernelParams değil, boot.extraModprobeConfig ile yapılmalı
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=0
  '';
  services.blueman.enable = true;  # Bluetooth yöneticisi (KDE bluedevil ile birlikte çalışır)

  ## KDE Connect
  programs.kdeconnect.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  ## ZSH (sistem seviyesi)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  ## NixOS sürümü (tek yer burası)
  system.stateVersion = "25.11";
}
