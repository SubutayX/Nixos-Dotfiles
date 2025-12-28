{
  programs.starship = {
    enable = true;

    settings = {
      # 1. Genel Ayarlar
      add_newline = true;
      command_timeout = 2000;

      # 2. SIRALAMA (Senin istediğin düzen)
      # Kullanıcı -> Bilgisayar -> Dizin -> Git -> Diller -> Alt Satıra Geç -> Karakter
      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$rust"
        "$nodejs"
        "$python"
        "$package"
        "$line_break"   # <-- Alt satıra geçiş
        "$character"
      ];

      right_format = "$cmd_duration$time";

      # --- MODÜLLER ---

      # Kullanıcı Adı
      username = {
        show_always = true; # Her zaman göster (root olmasan bile)
        style_user = "bold yellow";
        style_root = "bold red";
        format = "[🇹🇷 $user]($style)";
      };

      # Bilgisayar Adı (Hostname)
      hostname = {
        ssh_only = false; # SSH olmasa da göster
        style = "bold yellow";
        # Kullanıcı adıyla bitişik görünmesi için başında @ var
        format = "[@$hostname]($style) 🇹🇷"; 
      };

      # Dosya Yolu (Dizin)
      directory = {
        style = "bold cyan";
        # "in" kelimesi yerine klasör ikonu
        format = "in [📂 $path]($style) ";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      # Alt Satırdaki Komut İşareti
      character = {
        success_symbol = "[👉​](bold green)";
        error_symbol = "[✗](bold red)";
        vimcmd_symbol = "[❮](bold green)";
      };

      # Git Branch
      git_branch = {
        symbol = "🌱 ";
        style = "bold purple";
        format = "on [$symbol$branch]($style) ";
      };

      # Git Status
      git_status = {
        style = "bold red";
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "⚔️ ";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        stashed = "📦";
        modified = "📝";
        staged = "+";
        renamed = "»";
        deleted = "🗑️";
      };

      # Diğer Modüller (Sadeleştirildi)
      nix_shell = {
        symbol = "❄️ ";
        format = "[$symbol$state]($style) ";
        style = "bold blue";
      };

      package = {
        symbol = "📦 ";
        format = "[$symbol$version]($style) ";
        style = "dimmed yellow";
      };

      rust = {
        symbol = "🦀 ";
        format = "[$symbol($version)]($style) ";
        style = "bold red";
      };

      nodejs = {
        symbol = "⬢ ";
        format = "[$symbol($version)]($style) ";
        style = "bold green";
      };

      python = {
        symbol = "🐍 ";
        format = "[$symbol($version)]($style) ";
        style = "yellow";
      };

      # Sağ Taraf
      cmd_duration = {
        min_time = 2000;
        format = "[⏱️ $duration](bold yellow) ";
      };

      time = {
        disabled = false;
        format = "[$time]($style)";
        time_format = "%R";
        style = "dimmed white";
      };
    };
  };
}