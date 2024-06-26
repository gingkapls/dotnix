{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim.url = "github:pta2002/nixvim";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";


    # Making sure inputs follow nixpkgs
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Non Flake Inputs
    fzf-tab = { url = "github:Aloxaf/fzf-tab"; flake = false;
    };

  };

  outputs = { self, nixpkgs, home-manager, nix-colors, nixvim, nix-index-database, nix-vscode-extensions, ... }@inputs:
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

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

      nixosConfigurations = {
        tsukiyo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit self inputs outputs nix-colors; };
          modules = [
            # > Our main nixos configuration file <
            ./hosts/tsukiyo/configuration.nix

	          home-manager.nixosModules.home-manager {
	    	      home-manager = {
        	      extraSpecialArgs = { inherit self inputs outputs nix-colors nixvim nix-index-database nix-vscode-extensions; };
		            useGlobalPkgs = true;
		            useUserPackages = true;
		            users.gin = {
		              imports = [
		                ./users/gin/home.nix
                    nix-index-database.hmModules.nix-index
                    nix-colors.homeManagerModules.default
                    nixvim.homeManagerModules.nixvim
		              ];
		            };
		          };
	          }
          ];
        };
        
      };

      homeConfigurations = { # Gnome is finnicky with standlone HM
        # "gin@tsukiyo" = home-manager.lib.homeManagerConfiguration {
        #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
        #   extraSpecialArgs = { inherit self inputs outputs nix-colors nixvim nix-index-database; };
        #   modules = [
        #     ./users/gin/home.nix
        #     nix-index-database.hmModules.nix-index
        #     nix-colors.homeManagerModules.default
        #     nixvim.homeManagerModules.nixvim
        #   ];
        # };

        "gin@momiji" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit self inputs outputs nix-colors nixvim nix-index-database; };
          modules = [
            ./users/wsl/home.nix
            nix-index-database.hmModules.nix-index
            nix-colors.homeManagerModules.default
            nixvim.homeManagerModules.nixvim
          ];
        };
      };

      
    };
}
