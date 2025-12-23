{ pkgs, ... }:

{
  # Hem Bash hem Zsh hem de diğer shell'lerde geçerli olacak alias'lar
  environment.shellAliases = {
    sshEtu = "ssh root@10.0.10.194";
    # Temel Komutlar
    #ll = "ls -lh";             # Detaylı ve okunabilir liste
    grep = "grep --color=auto";
    c = "clear";

    lsa = "eza --icons";                # İkonlu hızlı liste
    ll  = "eza -l --icons --git";       # Detaylı ve Git bilgili liste
    lt  = "eza --tree --level=2";

    # NixOS Komutları (Standart)
    nr = "sudo nixos-rebuild switch"; 
    nrb = "sudo nixos-rebuild boot";
    nss = "nix-shell -p";

    # Günlük kullanım: sistem yapılandırmasını uygula
    nixos-switch="sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#nixos";

# Sistem güncelleme: flake'i güncelle ve uygula
    nixos-update="nix flake update $HOME/.dotfiles/nixos && sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#nixos";

# Temizlik: kullanılmayan paketleri ve geçmişi sil
    nixos-clean="sudo nix-collect-garbage -d";

    # Git Kısaltmaları
    g = "git";
    gs = "git status";
    ga = "git add .";
    gc = "git commit";
  };




  # Eğer özellikle Zsh'e özel ayarlar yapmak istersen burayı kullanabilirsin
  # programs.zsh.shellAliases = { ... }; 
}
