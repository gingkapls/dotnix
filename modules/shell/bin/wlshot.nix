{ pkgs }:

pkgs.writeShellScriptBin "wlshot" ''
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
      dimensions="$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | ${pkgs.slurp}/bin/slurp)"
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
  			${pkgs.libnotify}/bin/notify-send "$color_code" -i "$tmp_file" --app-name=colorpicker 
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
''
