# /etc/nixos/modules/dev/databases.nix
{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    dbeaver-bin 
    google-chrome
    kitty
#    thunderbird
    mailspring
    postman
    
  ];


programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Nix Flakes desteği için bu şart
};

}
