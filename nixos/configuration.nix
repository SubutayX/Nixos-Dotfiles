{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # === Core system ===
    ./modules/system.nix
    ./modules/users.nix
    ./modules/desktop.nix

    # === Development ===
    ./modules/ide.nix
    ./modules/languages.nix
    ./modules/programs.nix

    # === Services ===
    ./modules/nvidia.nix
    ./modules/postgresql.nix
    ./modules/starship.nix
    ./modules/nix-parallel-downloads.nix

    # === Hyprland (system-level) ===
      ./modules/hyprland.nix
  
  ];

  # =====================================================
  # Nix / Flakes
  # =====================================================
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # =====================================================
  # Home Manager (USER SCOPE – DOĞRU YER)
  # =====================================================
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  #home-manager.users.sentinel = import ./home/sentinel/home.nix;


  # =====================================================
  # Bluetooth
  # =====================================================
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  boot.kernelParams = [ "btusb.enable_autosuspend=n" ];
  services.blueman.enable = true;

  # =====================================================
  # KDE Connect
  # =====================================================
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

  # =====================================================
  # ZSH (system-level shell)
  # =====================================================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # =====================================================
  # System version
  # =====================================================
  system.stateVersion = "25.11";
}
