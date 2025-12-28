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
    bruno
#    insomnia
    libreoffice-fresh
    spotify
    #jetbrains.rust-rover
    wezterm

    openvpn
  ];


programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Nix Flakes desteği için bu şart
};

}
