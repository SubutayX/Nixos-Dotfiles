{ pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.starship = {
    enable = true;

    settings = {
      format = "$user@$hostname $directory $git_branch $rust $character";

      directory = {
        truncation_length = 3;
        style = "cyan";
      };

      git_branch = {
        symbol = "🌱 ";
      };

      rust = {
        symbol = "🦀 ";
      };

      character = {
        success_symbol = "❯";
        error_symbol = "❯";
      };
    };
  };
}
