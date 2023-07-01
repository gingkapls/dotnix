{ config, ... }:

{
  programs = {

    fzf = {
      enable = true;
    };

    nix-index = { 
      enable = true;
    };

    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };

    };
  
  };


  imports = [
    ./env.nix
    ./bin
    ./zsh.nix
    ./fish.nix
  ];


}
