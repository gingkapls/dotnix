{ config, pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      let-env config = {
        edit_mode: vi
      }
    '';
    package = pkgs.nushellFull;
    # environmentVariables = {
   # };
  };


}
