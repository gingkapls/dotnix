{ config, pkgs, nix-colors, inputs, lib, ... }:

with config.colorscheme.colors;

let
  i3-floating-decor = pkgs.writers.writePython3Bin "i3-floating-decor" { libraries = [ pkgs.python39Packages.i3ipc ]; }
      ''
      import i3ipc
      
      i3 = i3ipc.Connection()
      

      def border_on_floating(i3, e):

          if (e.container.floating == 'user_off'):
              e.container.command('border pixel 4')
              e.container.command('title_format "%title"')
          elif (e.container.floating == 'user_on'):
              e.container.command('border normal 0')
              e.container.command('title_format "<b></b>"')


      i3.on('window::floating', border_on_floating)

      i3.main()
      '';

  set-volume = pkgs.writeShellScriptBin "set-volume" ''
    case $1 in
      "up")
        ${pkgs.pamixer}/bin/pamixer --increase 5
      ;;

      "down")
        ${pkgs.pamixer}/bin/pamixer --decrease 5
      ;;
    esac
    
    vol="$(${pkgs.pamixer}/bin/pamixer --get-volume)"
    
    case $vol in
      "0")
      ${pkgs.libnotify}/bin/notify-send "  Muted" -i none -h string:synchronous:volume -t 1000 --app-name="volume"
      ;;

      *)
      ${pkgs.libnotify}/bin/notify-send "  $vol%" -i none -h int:value:$vol -h string:synchronous:volume -t 1000 --app-name="volume"
      ;;
    esac
  '';
  
  set-brightness = pkgs.writeShellScriptBin "set-brightness" ''
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
  '';

  xshot = pkgs.writeShellScriptBin "screenshot" ''
    shotDir="$HOME/Pictures/Shots"
    name="$(date +"%F_%H:%M:%S")-$(${pkgs.xdotool}/bin/xdotool getactivewindow getwindowname).png"
    ocrCommand="while pgrep ${pkgs.maim}/bin/maim; do wait; done; ${pkgs.tesseract}/bin/tesseract $shotDir/$name - 2>/dev/null | ${pkgs.xclip}/bin/xclip -selection primary"
    
    case $1 in
      "screen")
        ${pkgs.maim}/bin/maim | tee "$shotDir/$name" | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
        eval "$ocrCommand"
        ${pkgs.libnotify}/bin/notify-send "Screenshot Captured" -i "$shotDir/$name" --app-name "screenshot"
      ;;

      "window")
        ${pkgs.maim}/bin/maim -i $(${pkgs.xdotool}/bin/xdotool getactivewindow) | tee "$shotDir/$name" | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
        eval "$ocrCommand"
        ${pkgs.libnotify}/bin/notify-send "Screenshot Captured" -i "$shotDir/$name" --app-name "screenshot"
      ;;
    
      "select-window")
        ${pkgs.maim}/bin/maim -l -b 4 -st 9999999 | tee "$shotDir/$name" | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
        eval "$ocrCommand"
        ${pkgs.libnotify}/bin/notify-send "Screenshot Captured" -i "$shotDir/$name" --app-name "screenshot"
      ;;

      "select")
        ${pkgs.maim}/bin/maim -b 4 -s | tee "$shotDir/$name" | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
        eval "$ocrCommand"
        ${pkgs.libnotify}/bin/notify-send "Screenshot Captured" -i "$shotDir/$name" --app-name "screenshot"
      ;;

      "color-picker")
        ${pkgs.maim}/bin/maim -st 0 | convert - -resize 1x1\! -format '%[pixel:p{0,0}]' info:-
      ;;

      "ocr")
        ${pkgs.maim}/bin/maim -b -4 -s /tmp/ocrfile 
        ${pkgs.tesseract}/bin/tesseract /tmp/ocrfile | ${pkgs.xclip}/bin/xclip -selection primary
        ${pkgs.libnotify}/bin/notify-send "Screenshot Captured" --app-name "screenshot"
        rm /tmp/ocrfile
      ;;

      *)
        false
      ;;
    esac
  '';

  wlshot = pkgs.writeShellScriptBin "wlshot" ''
    ## Variables
    app_id="$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.. | select (.pid? and .focused?) | .app_id')"
    # screenshot_file="$HOME/Pictures/Shots/$(date +"%F_%T")_$app_id.png"
    tmp_file="/tmp/shot.png"
    
    notify='${pkgs.libnotify}/bin/notify-send -i "$tmp_file" "Screenshot Captured"  --app-name="screenshots" -t 2000'
    OCR='${pkgs.tesseract}/bin/tesseract "$tmp_file" - 2>/dev/null | ${pkgs.wl-clipboard}/bin/wl-copy -p'
    
    case "$1" in
    	"screen") ## Normal screenshot  
    		${pkgs.grim}/bin/grim -c - | ${pkgs.swappy}/bin/swappy -f - -o - | tee "$tmp_file" |  ${pkgs.wl-clipboard}/bin/wl-copy
    		eval "$notify"
    		;;

      "window")
        dimensions="$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.. | select(.pid? and .focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')"
    		${pkgs.grim}/bin/grim -g "$dimensions" - | ${pkgs.swappy}/bin/swappy -f - -o - | tee "$tmp_file" | ${pkgs.wl-clipboard}/bin/wl-copy
    		eval "$notify"
    		eval "$OCR" ;;
    
    	"select-window") ## Window screenshot
        dimensions="$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | ${pkgs.slurp}/bin/slurp -c "#${base05}")"
    		${pkgs.grim}/bin/grim -g "$dimensions" - | ${pkgs.swappy}/bin/swappy -f - -o - | tee "$tmp_file" | ${pkgs.wl-clipboard}/bin/wl-copy
    		eval "$notify"
    		eval "$OCR" ;;
    
    	"select") ## Partial screenshot 
        dimensions="$(${pkgs.slurp}/bin/slurp -c "#000000")"
    		${pkgs.grim}/bin/grim -g "$dimensions" - | ${pkgs.swappy}/bin/swappy -f - -o - | tee "$tmp_file" | ${pkgs.wl-clipboard}/bin/wl-copy
    		eval "$notify"
    		eval "$OCR" ;;
    
    	"color-picker") ## Color Picker
    		dimensions="$(${pkgs.slurp}/bin/slurp -p -c "#000000" -b "#00000000")"
        color_code="$(${pkgs.grim}/bin/grim -g "$dimensions" -t ppm - | ${pkgs.imagemagick}/bin/convert - -format '#%[hex:u]\n' info:-)"
    
    		if [ ! -z "$color_code" ]; then
    			${pkgs.wl-clipboard}/bin/wl-copy "$color_code"
    			${pkgs.imagemagick}/bin/convert -size 96x96 xc:"$color_code" "$tmp_file"
    			${pkgs.libnotify}/bin/notify-send "$(${pkgs.wl-clipboard}/bin/wl-paste)" -i /tmp/color.png --app-name=colorpicker 
          rm "$tmp_file"
        else
          false
        fi
          ;;
    
    	"ocr") ## OCR
        dimensions="$(${pkgs.slurp}/bin/slurp -c "#000000")"
    		${pkgs.grim}/bin/grim -g "$dimensions" -t ppm - | ${pkgs.tesseract}/bin/tesseract - - | ${pkgs.wl-clipboard}/bin/wl-copy -p
    		${pkgs.libnotify}/bin/notify-send "Copied to Clipboard" "\n$(${pkgs.wl-clipboard}/bin/wl-paste -p)" ;;

      *)
        printf "no options specified\n" && false ;;
    esac
  '';

  wlrecord = pkgs.writeShellScriptBin "wlrecord" ''
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
  '';

  meme-menu = pkgs.writeShellScriptBin "meme-menu" ''
    memeDir="$HOME/Pictures/Memes"
    meme="$(ls "$memeDir" | ${pkgs.bemenu}/bin/bemenu -i "''${BEMENU_OPTS}")"
    if [ ! -z $meme ]; then
      xclip -t image/png -selection clipboard "$memeDir/$meme"
    else
      false
    fi
  '';

  music-notifier = pkgs.writeShellScriptBin "music-notifier" ''
    for pid in $(pidof -x music-notifier); do
        if [ $pid != $$ ]; then
            kill -9 $pid
        fi 
    done >/dev/null
    
    killall -9 playerctl 2>/dev/null
    
    IFS='`' # good enough
    
    exec ${pkgs.playerctl}/bin/playerctl -Fsp playerctld metadata -f '{{status}}`{{title}}`{{artist}}`{{album}}`{{mpris:artUrl}}' | sed -u 's/&/&amp;/g' | while read -r playing title artist album art; do # & -> &amp to fix pango funky

    # printf "%s\n%s\n%s\n%s\n%s\n" "$playing" "$title" "$artist" "$album" "$art";
    printf '{"class": "%s", "text": "%s", "alt": "%s", "tooltip": "%s // %s"}\n' "$playing" "$title" "$playing" "$artist" "$album"

      [ ! -z "$art" ] && ${pkgs.libnotify}/bin/notify-send "$title" "\n''${artist%%,*} //\n$album" --expire-time "2000" --app-name "music-notifier" --icon "$art"; # Avoid multiple notifications due to missing album art
    done
  '';

in {
    home.packages = [
      i3-floating-decor
      set-volume
      set-brightness
      xshot
      wlshot
      wlrecord
      meme-menu
      music-notifier
    ];

}
