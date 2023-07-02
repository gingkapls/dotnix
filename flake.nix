{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, nix-colors, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        amethyst = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit self inputs outputs nix-colors; };
          modules = [
            # > Our main nixos configuration file <
            ./hosts/amethyst/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit self inputs outputs nix-colors; };
                users.gin = {
                  imports = [
                    ./users/gin/home.nix
                    # inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              };
            }
          ];
        };
        
      };
    };
}
