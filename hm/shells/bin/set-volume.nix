{ pkgs }: 

pkgs.writeShellScriptBin "set-volume" ''
   case $1 in
     "up")
       ${pkgs.pamixer}/bin/pamixer --increase 2
     ;;

     "down")
       ${pkgs.pamixer}/bin/pamixer --decrease 2
     ;;
   esac
   
   vol="$(${pkgs.pamixer}/bin/pamixer --get-volume)"
   
   case $vol in
     "0")
     ${pkgs.libnotify}/bin/notify-send " Muted" -i none -h string:synchronous:volume -t 1000 --app-name="volume"
     ;;

     *)
     ${pkgs.libnotify}/bin/notify-send " $vol%" -i none -h int:value:$vol -h string:synchronous:volume -t 1000 --app-name="volume"
     ;;
   esac
 ''
