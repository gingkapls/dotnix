{ pkgs }:

pkgs.writeShellScriptBin "set-brightness" ''

  brightness=$(($(${pkgs.brightnessctl}/bin/brightnessctl g) /1200))

  [ $brightness -lt 5 ] && exit

  case $1 in
    "up")
      ${pkgs.brightnessctl}/bin/brightnessctl -qe set 5%+
    ;;

    "down")
      ${pkgs.brightnessctl}/bin/brightnessctl -qe set 5%-
    ;;

    *)
    false
    ;;
  esac

  brightness=$(($(${pkgs.brightnessctl}/bin/brightnessctl g) /1200))
  ${pkgs.libnotify}/bin/notify-send "$brightness%" -i none -h int:value:$brightness -h string:synchronous:brightness -t 1000 --app-name="brightness"
''
