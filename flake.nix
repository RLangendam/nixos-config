{
  description = "Ralph's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      rust-overlay,
      aagl,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.ralph-desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          # Apply rust-overlay via nixpkgs.overlays so modules can still set nixpkgs.config
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
            }
          )
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.ralph = import ./home/ralph.nix;
            home-manager.users.ramon = import ./home/ramon.nix;

            imports = [ aagl.nixosModules.default ];
            # nix.settings = aagl.nixConfig; # Set up Cachix
            programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
          }
        ];
      };
    };
}
