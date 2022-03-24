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
        # Only for hm 21.11 (Remove later)
        enableFlakes = true;
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
