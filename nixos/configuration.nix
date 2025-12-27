{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/system.nix
    ./modules/users.nix
    ./modules/desktop.nix

    # geliştirme
    ./modules/ide.nix
    ./modules/languages.nix
    ./modules/programs.nix

    ./modules/nvidia.nix
    ./modules/postgresql.nix
    ./modules/starship.nix
    # ./modules/hyprland.nix
     ./modules/nix-parallel-downloads.nix
    # ./modules/promt.nix
  ];

  ## Flake + Nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## Home Manager (DOĞRU YER)
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sentinel = import ./modules/home.nix;

  ## Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  boot.kernelParams = [ "btusb.enable_autosuspend=n" ];
  services.blueman.enable = true;

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

  system.stateVersion = "25.11";
}
