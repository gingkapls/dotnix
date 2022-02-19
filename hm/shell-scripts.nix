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
              e.container.command('border normal 4')
              e.container.command('title_format "<b></b>"')


      i3.on('window::floating', border_on_floating)

      i3.main()
      '';

  set-volume = pkgs.writeShellScriptBin "set-volume" ''
    case $1 in
      "up")
        ${pkgs.pamixer}/bin/pamixer --increase 5;;
      "down")
        ${pkgs.pamixer}/bin/pamixer --decrease 5;;
    esac
    
    vol="$(${pkgs.pamixer}/bin/pamixer --get-volume)"
    
    case $vol in
      "0")
      ${pkgs.libnotify}/bin/notify-send "  Muted" -i none -h string:synchronous:volume -t 1000 --app-name="volume" ;;
      *)
      ${pkgs.libnotify}/bin/notify-send "  $vol%" -i none -h int:value:$vol -h string:synchronous:volume -t 1000 --app-name="volume" ;;
    esac
  '';
  set-brightness = pkgs.writeShellScriptBin "set-brightness" ''
    case $1 in
      "up")
        ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%+;;
      "down")
        ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%-;;
    esac

    brightness=$(($(${pkgs.brightnessctl}/bin/brightnessctl g)*100/120000))
    ${pkgs.libnotify}/bin/notify-send "  $brightness%" -i none -h int:value:$brightness -h string:synchronous:brightness -t 1000 --app-name="brightness"
  '';

  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    shotDir="$HOME/Pictures/Shots"
    name="$(date +"%F_%H:%M:%S")-$(${pkgs.xdotool}/bin/xdotool getactivewindow getwindowname).png"
    ocrCommand="while pgrep ${pkgs.maim}/bin/maim; do wait; done; ${pkgs.tesseract}/bin/tesseract $shotDir/$name - 2>/dev/null| ${pkgs.xclip}/bin/xclip -selection primary"
    
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

  meme-menu = pkgs.writeShellScriptBin "meme-menu" ''
    memeDir="$HOME/Pictures/Memes"
    meme="$(ls "$memeDir" | dmenu -i -fn 'Inter Medium 12' -nb '#${base00}' -nf '#${base05}' -sb '#${base09}' -sf '#${base00}')"
    if [ ! -z $meme ]; then
      xclip -t image/png -selection clipboard "$memeDir/$meme"
    else
      false
    fi
    '';
in

  {
    home.packages = [
      i3-floating-decor
      set-volume
      set-brightness
      screenshot
      meme-menu
    ];

  }
