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

    # Yeni Dotfiles Sistemi için Özel Komut
    nixos-update = "sudo nixos-rebuild switch -I nixos-config=$HOME/.dotfiles/nixos/configuration.nix";
    nixos-update-upgrade = "sudo nixos-rebuild switch --upgrade -I nixos-config=$HOME/.dotfiles/nixos/configuration.nix";
    clean = "sudo nix-collect-garbage -d"; 
    # Git Kısaltmaları
    g = "git";
    gs = "git status";
    ga = "git add .";
    gc = "git commit";
  };




  # Eğer özellikle Zsh'e özel ayarlar yapmak istersen burayı kullanabilirsin
  # programs.zsh.shellAliases = { ... }; 
}
