# /etc/nixos/modules/users.nix
{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
  ];

  # Kullanıcı tanımları
  users.users.sentinel = {
    isNormalUser = true;
    description = "Sentinel";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Zsh sadece temel özellikleri aktif etsin
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # Zoxide'ı NixOS seviyesinde böyle aktif ediyoruz:
  programs.zoxide.enable = true;

  # Git ve Sudo ayarları
  programs.git.enable = true;
  security.sudo.wheelNeedsPassword = false;
}