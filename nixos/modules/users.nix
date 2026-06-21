# nixos/modules/users.nix
{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
  ];

  # ── Kullanıcı tanımı ──────────────────────────────────────────────
  users.users.sentinel = {
    isNormalUser = true;
    description = "Sentinel";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"  # Ağ yönetimi
      "wheel"           # sudo erişimi
      "libvirtd"        # virt-manager / KVM erişimi
      "podman"          # Rootless podman erişimi
      "dialout"         # Seri port (ARM gömülü programlama için)
      "plugdev"         # USB cihaz erişimi (probe-rs, stlink için)
    ];
  };

  # ── Yardımcı araçlar ──────────────────────────────────────────────
  programs.zoxide.enable = true;  # Akıllı dizin geçmişi
  programs.git.enable = true;

  # ── Güvenlik ──────────────────────────────────────────────────────
  security.sudo.wheelNeedsPassword = false;
}
