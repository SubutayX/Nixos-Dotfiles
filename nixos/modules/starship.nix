{ pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      # ANA FORMAT — DİKKAT: bilinçli boşluklar
      format = "$username@$hostname $directory$git_branch$rust$nix_shell\n$character";

      username = {
        show_always = true;
        style_user = "fg:110";
      };

      hostname = {
        ssh_only = false;
        style = "fg:110";
      };

      directory = {
        truncation_length = 3;
        fish_style_pwd_dir_length = 1;
        style = "fg:179";
      };

      git_branch = {
        symbol = " 🌱 ";
        style = "fg:149";
      };

      rust = {
        symbol = " 🦀 ";
        style = "fg:208";
      };

      nix_shell = {
        symbol = " ❄️ ";
        format = "$symbol$state";
        style = "fg:81";
      };

      character = {
        success_symbol = "👉 ";
        error_symbol = "✗ ";
      };
    };
  };
}
