# /etc/nixos/modules/desktop.nix (Nihai Hali)
{ config, pkgs, ... }:

{
  imports = [
    ./font.nix  # <-- BU SATIRI EKLEYİN (Yeni modülümüzü çağırıyoruz)
  ];

  # X11 ve Masaüstü ortamı ayarları
  services.xserver.enable = true;
 # services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

services.displayManager.sddm = {
  enable = true;
  settings = {
    General = {
      Numlock = "on";
    };
  };
};


  # Klavye ve Yerel ayarlar
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
  console.keyMap = "trq";
  
  # Uluslararasılaştırma ayarları
   i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };
  
  # Ses ayarları
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}