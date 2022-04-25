{ pkgs }:

pkgs.writeShellScriptBin "screenshot" ''
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
''
