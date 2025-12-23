{
  description = "NixOS flake configuration for nixos host";

  inputs = {
    # NixOS 26.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Home Manager (main branch, nixpkgs ile senkron)
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
