{ pkgs, ... }:

{
  environment.shellAliases = {
    sshEtu = "ssh root@10.0.10.194";

    grep = "grep --color=auto";
    c    = "clear";

    lsa = "eza --icons";
    ll  = "eza -l --icons --git";
    lt  = "eza --tree --level=2";

    # ── NixOS ─────────────────────────────────────────────────────────
    nr  = "sudo nixos-rebuild switch";
    nrb = "sudo nixos-rebuild boot";
    nss = "nix-shell -p";

    nixos-switch = "sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#nixos";
    nixos-update = "nix flake update --flake $HOME/.dotfiles/nixos && sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#nixos";
    nixos-clean  = "sudo nix-collect-garbage -d";

    # ── Git ───────────────────────────────────────────────────────────
    g  = "git";
    gs = "git status";
    ga = "git add .";
    gc = "git commit";
    gl = "lazygit";

    # ── 🚀 Geliştirme Servisleri ──────────────────────────────────────
    # Yönetilen servisler:
    #   postgresql  → 127.0.0.1:5432  (ilişkisel veritabanı)
    #   mongodb     → 127.0.0.1:27017 (NoSQL belge veritabanı)
    #   dragonfly   → 127.0.0.1:6379  (Redis uyumlu önbellek)
    #   rabbitmq    → 127.0.0.1:5672  (mesaj aracısı)
    #
    # Servis eklemek/çıkarmak için bu satırı düzenle:
    #   dev_start = "sudo systemctl start postgresql mongodb dragonfly rabbitmq YENİ_SERVİS";

    dev_start = "sudo systemctl start postgresql mongodb dragonfly rabbitmq && echo '' && echo '✓ Geliştirme servisleri başlatıldı:' && echo '  PostgreSQL  → localhost:5432' && echo '  MongoDB     → localhost:27017' && echo '  DragonFly   → localhost:6379  (Redis uyumlu)' && echo '  RabbitMQ    → localhost:5672'";

    dev_stop = "sudo systemctl stop dragonfly mongodb rabbitmq postgresql && echo '' && echo '✓ Tüm geliştirme servisleri durduruldu.'";

    dev_status = "echo '── Geliştirme Servisleri ──────────────────────────────' && systemctl is-active --quiet postgresql && echo '✓ PostgreSQL  çalışıyor  (5432)' || echo '✗ PostgreSQL  durdu'; systemctl is-active --quiet mongodb    && echo '✓ MongoDB     çalışıyor  (27017)' || echo '✗ MongoDB     durdu'; systemctl is-active --quiet dragonfly  && echo '✓ DragonFly   çalışıyor  (6379)' || echo '✗ DragonFly   durdu'; systemctl is-active --quiet rabbitmq  && echo '✓ RabbitMQ    çalışıyor  (5672)' || echo '✗ RabbitMQ    durdu'";

    dev_restart = "sudo systemctl restart postgresql mongodb dragonfly rabbitmq && echo '✓ Tüm servisler yeniden başlatıldı.'";
  };
}
