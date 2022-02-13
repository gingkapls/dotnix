{ config, pkgs, ... }:

{
  # Shell
  programs.nix-index = { 
    enable = true;
    enableZshIntegration = true;
  };

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    dotDir = "/.config/zsh";
    shellAliases = {
      ls = "ls --color=auto";
      la = "ls --all --color=auto";
      ll = "ls -l --color=auto";
      rm = "rm -i";
      cp = "cp -i --reflink=auto";
      vim = "nvim";
      ip = "ip -c";
      perl-rename = "perl-rename --interactive";
    };
    initExtraFirst = ''
      setopt nocaseglob
    '';
    autocd = true;
    history.save = 50000;
    history.share = true;
  };

}
