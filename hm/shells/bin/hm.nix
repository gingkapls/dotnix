{ config, pkgs }:

pkgs.writeShellScriptBin "hm"
''
    FLAKE_DIR="${config.home.homeDirectory}/.dotnix"
    user="${config.home.username}"
    host="$(hostname)"

    _nix() {
        nixos-rebuild "$1" --flake "''${FLAKE_DIR}/#''${host}" --use-remote-sudo
        ${pkgs.libnotify.out}/bin/notify-send "nixos $1 complete"
    }

    _hm() {
        home-manager "$1" --flake "''${FLAKE_DIR}/#''${user}@''${host}"
        ${pkgs.libnotify.out}/bin/notify-send "home-manager $1 complete"
    }


    case "$1" in
        "switch")
            case "$2" in
                "nix") _nix switch ;;
                "hm") _hm switch;;
                *) printf "???\n";;
            esac;;

        "build")
            case "$2" in
                "nix") _nix build;; 
                "hm") _hm build;;
                *) printf "???\n";;
            esac;;

        "boot")
            _nix boot;;
            
        "test")
            _nix test;;

        *) ${pkgs.helix.out}/bin/hx "''${FLAKE_DIR}";;
    esac
''
