{
  description = "Ralph's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    affinity-nix.url = "github:mrshmllow/affinity-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      rust-overlay,
      affinity-nix,
      nix-flatpak,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.ralph-desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          # Apply rust-overlay via nixpkgs.overlays so modules can still set nixpkgs.config
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
                affinity-nix.overlays.default
              ];
            }
          )
          {
            nixpkgs.config.permittedInsecurePackages = [
              "electron-39.8.10"
            ];
          }
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.ralph = {
              imports = [
                ./home/ralph.nix
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };
            home-manager.users.ramon = {
              imports = [
                ./home/ramon.nix
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
