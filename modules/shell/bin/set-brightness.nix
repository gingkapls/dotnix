{ pkgs }:

pkgs.writeShellScriptBin "set-brightness" ''
  case $1 in
    "up")
      ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%+
    ;;

    "down")
      ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%-
    ;;

    *)
    false
    ;;
  esac

  brightness=$(($(${pkgs.brightnessctl}/bin/brightnessctl g)*100/120000))
  ${pkgs.libnotify}/bin/notify-send "  $brightness%" -i none -h int:value:$brightness -h string:synchronous:brightness -t 1000 --app-name="brightness"
''
