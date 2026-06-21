# nixos/modules/system.nix
{ config, pkgs, ... }:

{
  # ── Önyükleyici (GRUB - UEFI) ─────────────────────────────────────
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];   # UEFI modu
    efiSupport = true;
    useOSProber = true;      # Diğer işletim sistemlerini otomatik tanı
    configurationLimit = 5;  # GRUB menüsünde en fazla 5 giriş
  };

  # ── Ağ ────────────────────────────────────────────────────────────
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ── Saat Dilimi ───────────────────────────────────────────────────
  time.timeZone = "Europe/Istanbul";

  # ── Yazıcı Servisi ────────────────────────────────────────────────
  services.printing.enable = true;

  # ── Genel Programlar ──────────────────────────────────────────────
  programs.firefox.enable = true;

  # ── Nixpkgs izinleri ──────────────────────────────────────────────
  # allowUnfree tek yerden yönetiliyor (vscode, chrome, spotify vb. için şart)
  nixpkgs.config.allowUnfree = true;
}
