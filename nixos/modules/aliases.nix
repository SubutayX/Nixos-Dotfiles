{ pkgs, ... }:

{
  environment.shellAliases = {
    sshEtu = "ssh root@10.0.10.194";

    grep = "grep --color=auto";
    c = "clear";

    lsa = "eza --icons";
    ll  = "eza -l --icons --git";
    lt  = "eza --tree --level=2";

    # NixOS Komutları
    nr  = "sudo nixos-rebuild switch";
    nrb = "sudo nixos-rebuild boot";
    nss = "nix-shell -p";

    # Flake kullanan komutlar
    nixos-switch = "sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#nixos";
    nixos-update = "nix flake update --flake $HOME/.dotfiles/nixos && sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#nixos";

    # Temizlik
    nixos-clean = "sudo nix-collect-garbage -d";

    # Git
    g  = "git";
    gs = "git status";
    ga = "git add .";
    gc = "git commit";
  };
}
