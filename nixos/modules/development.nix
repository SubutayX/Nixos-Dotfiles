# nixos/modules/development.nix
# Programlama dilleri, SDK'lar, konteyner araçları, IDE'ler ve geliştirici yardımcıları
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

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

    # ── 🐍 Python ─────────────────────────────────────────────────────
    python3
    python3Packages.defusedxml
    python3Packages.packaging

    # ── ☕ Java ───────────────────────────────────────────────────────
    jdk   # OpenJDK (JRE dahil)

    # ── 🐳 Konteyner & Orkestrasyon ──────────────────────────────────
    kubectl    # Kubernetes CLI
    minikube   # Yerel Kubernetes kümesi
    k9s        # Terminal tabanlı Kubernetes UI
    cri-tools  # crictl (Container Runtime Interface CLI)
    stern      # Kubernetes çoklu pod log takibi

    # ── 🗄️  Veritabanı & Önbellek ────────────────────────────────────
    dbeaver-bin   # Evrensel veritabanı istemcisi
    dragonflydb   # Redis uyumlu yüksek performanslı önbellek

    # ── 💻 IDE & Editörler ────────────────────────────────────────────
    vscode           # Visual Studio Code
    jetbrains-toolbox
    zed-editor       # Zed editörü
    vim
    micro            # Basit terminal editörü
    kdePackages.kate # KDE gelişmiş metin editörü

    # ── 🌐 API & Ağ Araçları ─────────────────────────────────────────
    bruno   # Açık kaynak API istemcisi

    # ── 🔍 Asenkron İzleme ───────────────────────────────────────────
    tokio-console   # Tokio async runtime görselleştirici

    # ── 🔧 Versiyon Kontrolü ─────────────────────────────────────────
    git
    gh   # GitHub CLI
  ];

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
}
