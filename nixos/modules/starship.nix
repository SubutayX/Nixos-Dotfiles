{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    
    settings = {
      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
      };
      
      directory = {
        truncation_length = 3;
        fish_style_pwd_dir_length = 1;
      };

      rust = {
        symbol = "🦀 ";
      };

      git_branch = {
        symbol = "🌱 ";
      };
    };
  };
}
