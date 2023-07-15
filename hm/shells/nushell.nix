{ config, pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      let-env config = {
        edit_mode: vi
        show_banner: false
      
      keybindings: [
        {
          name: trigger-completion-menu
          modifier: none
          keycode: tab
          mode: [emacs vi_normal vi_insert]
          event: { 
            until: [
              { send: menu name: completion_menu }
              { send: menunext }
              { edit: complete }
            ]
          }
        }
      ]
    }
    '';
    package = pkgs.nushellFull;
    # environmentVariables = {
   # };
  };


}
