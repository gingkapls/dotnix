{ lib, pkgs, ... }: {
  hjem.users.gin.xdg.config.files = {
    "git/config".text = ''
    [gpg]
    	format = "openpgp"

    [gpg "openpgp"]
    	program = "${lib.getExe pkgs.gnupg}"

    [user]
    	email = "73906888+gingkapls@users.noreply.github.com"
    	name = "gin"
    '';
  };
}
