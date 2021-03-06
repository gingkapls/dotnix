{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs = { url = "nixpkgs/nixos-21.11";};

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = { url = "github:misterio77/nix-colors"; };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

  };

  outputs = { self, nixpkgs, nix-colors, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        amethyst = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs self nix-colors; 
        };

        modules = [
          ./hosts/amethyst/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager = {

              extraSpecialArgs = {
                inherit inputs self nix-colors; 
              };

              useUserPackages = true;
              useGlobalPkgs = true;
              users.gin = { 
                imports = [ 
                  ./users/gin
	                inputs.nixvim.homeManagerModules.nixvim
	              ];
	            };
            }; 
	        }

        ];

      };   

    };
  };
}
