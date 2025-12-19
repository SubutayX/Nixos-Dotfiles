# /etc/nixos/modules/system.nix
{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Ağ ayarları
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;




# ----------------------------------------------
  # SİSTEM YÖNETİMİ VE GENERASYON LİMİTİ
  # ----------------------------------------------
  
  # system.systemBuilderCommands = ""; burası boş kalacak

  # Generasyon temizliğini, izin sorunlarını önlemek için aktivasyon betiğinde yapıyoruz.
  system.activationScripts.cleanup = ''
    # Sistem profil generasyonlarını 5 ile sınırla (Sadece korunacak generasyon sayısını belirtiyoruz)
    # --delete-generations, bu sayıdan daha büyük numaralara sahip generasyonları siler.
    ${pkgs.nix}/bin/nix-env --delete-generations 5 --profile /nix/var/nix/profiles/system
  '';
  
  # Boot Yöneticisi için limit koymak (Menüyü temiz tutar)
  boot.loader.systemd-boot.configurationLimit = 5;



  # Saat Dilimi
  time.timeZone = "Europe/Istanbul";

  # Yazıcı Servisleri
  services.printing.enable = true;

  # Genel Programlar
  programs.firefox.enable = true;
  
  # İzinler
  nixpkgs.config.allowUnfree = true;

  # Sistem genelindeki paketler
  #environment.systemPackages = with pkgs; [
  #  vscode
    # zsh (Daha önce bahsettiğimiz gibi, programs.zsh.enable olduğu için bu satır gereksizdir, ancak şimdilik bırakıyorum. İleride temizleyebilirsiniz.)
  #];
  
  # NixOS Sürümü
  system.stateVersion = "25.11";
}
