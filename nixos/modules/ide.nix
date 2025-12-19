# /etc/nixos/modules/dev/ide.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode # Visual Studio Code
    
    # İstenirse diğer editörler buraya eklenebilir:
    # neovim
    # emacs
  ];
}
