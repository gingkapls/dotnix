{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
        modules = [
          ./hosts/amethyst/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.gin = { 
              imports = [ 
                ./hm/home.nix
	        inputs.nixvim.homeManagerModules.nixvim
	      ];
	    }; 
	  }
        ];
      };   
    };
  };
}
