# nixos/modules/development.nix
# Programlama dilleri, SDK'lar, konteyner araçları, IDE'ler ve geliştirici yardımcıları
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # ── 🏗️  Derleme Araçları (Build Essentials) ───────────────────────
    # Rust dahil birçok dil C linker'ına ihtiyaç duyar
    gcc          # GNU C/C++ derleyici + linker
    clang        # LLVM/Clang derleyici (alternatif)
    llvm         # LLVM araç zinciri
    gnumake      # Make build sistemi
    cmake        # Cross-platform build sistemi
    ninja        # Hızlı paralel build sistemi
    pkg-config   # Kütüphane bağımlılık yönetimi
    meson        # Modern build sistemi
    gdb          # GNU hata ayıklayıcı
    lldb         # LLVM hata ayıklayıcı

    # ── 🦀 Rust Ekosistemi ────────────────────────────────────────────
    rustc
    cargo
    rust-src
    rust-analyzer
    cargo-audit
    cargo-expand
    cargo-flamegraph
    cargo-generate
    cargo-outdated
    cargo-watch

    # ── ⚙️  C/C++ & Gömülü (Embedded) Sistemler ──────────────────────
    # gcc-arm-embedded: arm-none-eabi-gcc + arm-none-eabi-newlib birlikte gelir
    gcc-arm-embedded
    openocd
    probe-rs-tools   # probe-rs CLI araçları (cargo-flash, cargo-embed, vs.)
    stlink           # ST-Link programlayıcı

    # ── 🟣 .NET ───────────────────────────────────────────────────────
    dotnet-sdk_9         # .NET 9 SDK (runtime dahil)
    dotnet-aspnetcore_9  # ASP.NET Core 9 runtime

    # ── 🟨 JavaScript / TypeScript ───────────────────────────────────
    bun      # Bun runtime + paket yöneticisi
    nodejs   # Node.js (npm dahil)

    # ── 🐹 Go ─────────────────────────────────────────────────────────
    go
    golangci-lint  # Go linter koleksiyonu

    # ── 🐍 Python ─────────────────────────────────────────────────────
    python3
    python3Packages.defusedxml
    python3Packages.packaging
    python3Packages.pip          # Paket yöneticisi
    python3Packages.virtualenv   # İzole Python ortamı

    # ── ☕ Java ───────────────────────────────────────────────────────
    jdk    # OpenJDK (JRE dahil)
    maven  # Java proje yöneticisi

    # ── 🔍 Arama & Gezinme (Geliştirici Verimliliği) ─────────────────
    ripgrep   # Çok hızlı grep alternatifi (rg) — birçok IDE kullanır
    fd        # Hızlı find alternatifi
    fzf       # Bulanık arama (fuzzy finder) — shell entegrasyonu
    zoxide    # Akıllı 'cd' alternatifi (zaten users.nix'te ama burada da iyi)

    # ── 📊 Veri İşleme ───────────────────────────────────────────────
    jq        # JSON işleme (API geliştirmede zorunlu!)
    yq-go     # YAML/JSON/TOML işleme
    xh        # HTTP istemcisi (httpie alternatifi, Rust ile yazılmış)

    # ── 🌿 Git İyileştirmeleri ────────────────────────────────────────
    git
    gh           # GitHub CLI
    lazygit      # Git TUI (terminal arayüzü)
    delta        # Güzel git diff görüntüleyici
    git-lfs      # Büyük dosya desteği

    # ── 🐳 Konteyner & Orkestrasyon ──────────────────────────────────
    kubectl    # Kubernetes CLI
    minikube   # Yerel Kubernetes kümesi
    k9s        # Terminal tabanlı Kubernetes UI
    cri-tools  # crictl (Container Runtime Interface CLI)
    stern      # Kubernetes çoklu pod log takibi
    helm       # Kubernetes paket yöneticisi
    dive       # Docker/Podman image katman analizi

    # ── 🗄️  Veritabanı & Önbellek ────────────────────────────────────
    dbeaver-bin   # Evrensel veritabanı istemcisi
    dragonflydb   # Redis uyumlu yüksek performanslı önbellek
    redis         # Redis CLI araçları (redis-cli)

    # ── 💻 IDE & Editörler ────────────────────────────────────────────
    vscode           # Visual Studio Code
    jetbrains-toolbox
    zed-editor       # Zed editörü
    vim
    micro            # Basit terminal editörü
    kdePackages.kate # KDE gelişmiş metin editörü

    # ── 🌐 API & Ağ Araçları ─────────────────────────────────────────
    bruno          # Açık kaynak API istemcisi
    wireshark-qt   # Ağ analiz aracı
    nmap           # Ağ tarayıcı / port scanner

    # ── 🔐 Güvenlik & Gizlilik ───────────────────────────────────────
    gnupg    # GPG (git commit imzalama, şifreleme)
    age      # Modern dosya şifreleme aracı
    sops     # Şifreli secret yönetimi (k8s/gitops)
    mkcert   # Yerel geliştirme için HTTPS sertifikası

    # ── 🔍 Asenkron & Performans İzleme ──────────────────────────────
    tokio-console   # Tokio async runtime görselleştirici
    hyperfine       # CLI komut kıyaslama (benchmarking)
    tokei           # Kod satırı ve dil istatistiği

    # ── 🖥️  Terminal Multiplexer ──────────────────────────────────────
    zellij   # Modern terminal multiplexer (Rust tabanlı)
    tmux     # Klasik terminal multiplexer

    # ── 📋 Görev Yöneticisi & Yardımcılar ────────────────────────────
    just      # Basit komut çalıştırıcı (Makefile alternatifi)
    watchexec # Dosya değişikliğinde komut çalıştır (her dil için)
    glow      # Terminal içinde Markdown görüntüleyici
  ];

  # ── 🐉 DragonFly Redis-uyumlu önbellek servisi ────────────────────
  # wantedBy = [] → sistem açılışında OTOMATİK başlamaz.
  # "dev_start" alias'ı ile manuel olarak başlatılır.
  systemd.services.dragonfly = {
    description = "DragonFly Redis-uyumlu yüksek performanslı önbellek";
    after       = [ "network.target" ];
    wantedBy    = [];   # Otomatik başlatma YOK — dev_start ile yönetilir

    serviceConfig = {
      ExecStart    = "${pkgs.dragonflydb}/bin/dragonfly --logtostderr --bind 127.0.0.1 --port 6379";
      Restart      = "on-failure";
      DynamicUser  = true;          # Güvenlik: izole kullanıcı
      StateDirectory = "dragonfly"; # /var/lib/dragonfly — kalıcı veri
    };
  };

  # ── 🐳 Podman (Rootless container runtime, Docker uyumlu) ─────────
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;   # 'docker' komutu → podman yönlendirmesi
    defaultNetwork.settings.dns_enabled = true;
  };

  # ── 🐇 RabbitMQ mesaj aracısı ─────────────────────────────────────
  services.rabbitmq.enable = true;

  # ── 📁 direnv + nix-direnv (Flake tabanlı proje ortamları) ────────
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ── 🔐 GnuPG agent (git commit imzalama için) ─────────────────────
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;  # GPG key'i SSH anahtarı olarak da kullanabilirsin
  };
}
