{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    interactiveShellInit = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';
  };

  programs.starship = {
    enable = true;

    settings = {
      format = "$user@$hostname $directory $git_branch $rust $character";

      directory.truncation_length = 3;

      git_branch.symbol = "🌱 ";
      rust.symbol = "🦀 ";

      character = {
        success_symbol = "❯";
        error_symbol = "❯";
      };
    };
  };
}
