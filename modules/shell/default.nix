{ config, ... }:

{
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    nix-index = { 
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        # Only for hm 21.11 (Remove later)
        enableFlakes = true;
      };
    };
  
    bash.enable = true;
  };


  imports = [
    ./env.nix
    ./bin
    ./zsh.nix
  ];


}
