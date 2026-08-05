{
  description = "gin's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hjem.url = "github:feel-co/hjem"; 

    # Making sure inputs follow nixpkgs
    hjem.inputs.nixpkgs.follows = "nixpkgs";

    # Non Flake Inputs
    fzf-tab = { url = "github:Aloxaf/fzf-tab"; flake = false; };

  };

  outputs = { self, nixpkgs, ... }@inputs: let
  in {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        tsukiyo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/tsukiyo.nix
            inputs.hjem.nixosModules.default
          ];
        };
      };
    };
}
