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

    blender-bin.url = "github:edolstra/nix-warez?dir=blender";
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
      blender-bin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Prepare pkgs with your overlays and permitted insecure packages for standalone HM
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-39.8.10"
          ];
        };
        overlays = [
          rust-overlay.overlays.default
          affinity-nix.overlays.default
        ];
      };
    in
    {
      # Standalone Home Manager configurations
      homeConfigurations = {
        "anneke" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/anneke.nix
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };

        "ralph" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            inherit blender-bin;
          };
          modules = [
            ./home/ralph.nix
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };

        "ramon" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/ramon.nix
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };
      };

      # Existing NixOS System Configuration
      nixosConfigurations.ralph-desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
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
            home-manager.backupFileExtension = "backup";

            home-manager.users.anneke = {
              home.language = {
                base = "nl_NL.UTF-8";
              };
              xdg.configFile."kdeglobals".text = ''
                [Translations]
                LANGUAGE=nl:en_US
              '';
              imports = [
                ./home/anneke.nix
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };
            home-manager.users.ralph = {
              home.language = {
                base = "en_US.UTF-8";
                time = "nl_NL.UTF-8";
                monetary = "nl_NL.UTF-8";
              };
              imports = [
                ./home/ralph.nix
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };
            home-manager.users.ramon = {
              home.language = {
                base = "pt_BR.UTF-8";
                time = "nl_NL.UTF-8";
                monetary = "nl_NL.UTF-8";
              };
              xdg.configFile."kdeglobals".text = ''
                [Translations]
                LANGUAGE=pt:en_US
              '';
              imports = [
                ./home/ramon.nix
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };

            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit blender-bin;
            };
          }
        ];
      };
    };
}
