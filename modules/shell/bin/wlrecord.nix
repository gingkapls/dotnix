{ pkgs }:

pkgs.writeShellScriptBin "wlrecord" ''
  #active_sink=$(pacmd list-sources | awk 'c&&!--c;/* index*/{c=1}' | awk '{gsub(/<|>/,"",$0); print $NF}')
  #active_sink=$(pactl get-default-source)"
  
  filepath="/mnt/data/files/Videos/Recordings"
  
  if [ -z "$(pgrep wf-recorder)" ];
  	then 
  	case $1 in 
  		"screen") ## Record entire screen
        ${pkgs.libnotify}/bin/notify-send "Recording Started $active_sink"
  		  ${pkgs.wf-recorder}/bin/wf-recorder -f "$filepath/tmp.mp4" -a "$active_sink" >/dev/null 2>&1 &
  		  pkill -RTMIN+8 waybar;;
  
  		"select") ## Record selected region
        ${pkgs.libnotify}/bin/notify-send "Recording Started $active_sink"
        dimensions="$(${pkgs.slurp}/bin/slurp -c "#000000")"
  			${pkgs.wf-recorder}/bin/wf-recorder -f "$filepath/tmp.mp4" -a "$active_sink" -g "$dimensions"  >/dev/null 2>&1 &
  			sleep 2 
  				while [ ! -z $(pgrep -x ${pkgs.slurp}/bin/slurp) ]; do wait; done; pkill -RTMIN+8 waybar ;;
  
  		"window") ## Record a window
        dimensions="$(${pkgs.sway}/bin/swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | ${pkgs.slurp}/bin/slurp -c "#000000" )"
  			${pkgs.wf-recorder}/bin/wf-recorder -f "$filepath/tmp.mp4" -a "$active_sink" -g "$dimensions" >/dev/null 2>&1 &
  			 sleep 2
  				 while [ ! -z $(pgrep -x ${pkgs.slurp}/bin/slurp) ]; do wait; done; pkill -RTMIN+8 waybar ;;
  
      *)
        printf "No valid input\n" && false ;;
  	esac
  else ## Stop ${pkgs.wf-recorder}/bin/wf-recorder if it's already running
  
  	pkill --signal=SIGINT wf-recorder && ${pkgs.libnotify}/bin/notify-send "Recording Complete"
  	while [ ! -z "$(pgrep -x wf-recorder)" ]; do wait; done; pkill -RTMIN+8 waybar ## Waiting for wf-recorder to stop 
  
  	name="$(${pkgs.gnome.zenity}/bin/zenity --entry --text "enter a filename")" 
  	printf "$name"
    [ ! -z "$name" ] && mv "$filepath/tmp.mp4" "$filepath/$(date +%F_%T) $name.mp4" || mv "$filepath/tmp.mp4" "$filepath/$(date +%F_%T).mp4" 
  	#perl-rename "s/\.(mkv|mp4)$/ $name$&/" "$(ls -td /mnt/data/files/Videos/Recordings/* | head -n1)" ## this was so dumb
  fi
''
