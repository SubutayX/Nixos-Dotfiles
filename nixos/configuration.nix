# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/users.nix
      ./modules/desktop.nix
      ./modules/system.nix
      
      # YENİ GELİŞTİRME MODÜLLERİ
      ./modules/ide.nix
      ./modules/languages.nix
      ./modules/programs.nix
     
      ./modules/nvidia.nix
      ./modules/postgresql.nix
      ./modules/starship.nix
      
      # BURADAN ./modules/home.nix SATIRINI SİLDİK!

      #./modules/hyprland.nix
      <home-manager/nixos>      
    ];

  # Home Manager yapılandırması burada kalmaya devam edecek (Doğru yer burası)
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sentinel = import ./modules/home.nix;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.bluetooth.enable = true;
  boot.kernelParams = [ "btusb.enable_autosuspend=n" ];
  hardware.bluetooth.powerOnBoot = true; 
  services.blueman.enable = true;

  #kde connect
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
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
