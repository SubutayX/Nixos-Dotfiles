# /etc/nixos/modules/dev/languages.nix
{ pkgs, lib, ... }:

# 'rust-bin' hatasına neden olan 'let' bloğunu tamamen kaldırıyoruz
# let
#   rust-tools = pkgs.rust-bin.stable.latest;
# in

{
  # environment.systemPackages bloğu:
  environment.systemPackages = with pkgs; [
    # ----------------
    # 1. Rust Geliştirme Ortamı
    # ----------------
    # Temel araçlar
    rustc
    cargo
    
    # Geliştirme Verimliliği Araçları (Standart Nixpkgs paketlerini kullanıyoruz)
    rust-analyzer    # Standart pakette genellikle mevcuttur
    clippy           # Standart pakette genellikle mevcuttur
    rustfmt          # Standart pakette genellikle mevcuttur
    
    # Hata Ayıklama (Debugging)
    lldb
    git
    # ----------------
    # 2. Go Geliştirme Ortamı
    # ----------------
    go             
    gopls          
    go-tools       

    # ----------------
    # 3. Java
    # ----------------
    jdk17
    gcc
  ];
}