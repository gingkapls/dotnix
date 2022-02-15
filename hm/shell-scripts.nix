{ config, pkgs, inputs, lib, ... }:

let
  i3-floating-decor = pkgs.writers.writePython3Bin "i3-floating-decor" { libraries = [ pkgs.python39Packages.i3ipc ]; }
      ''
      import i3ipc
      
      i3 = i3ipc.Connection()
      

      def border_on_floating(i3, e):

          if (e.container.floating == 'user_off'):
              e.container.command('border pixel 4')
          elif (e.container.floating == 'user_on'):
              e.container.command('border normal 4')


      i3.on('window::floating', border_on_floating)

      i3.main()
      '';

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';

  set-volume = pkgs.writeShellScriptBin "set-volume" ''
    case $1 in
      "up")
        pamixer --increase 5;;
      "down")
        pamixer --decrease 5;;
    esac
    
    vol="$(pamixer --get-volume)"
    
    case $vol in
      "0")
      notify-send "  Muted" -i none -h string:synchronous:volume -t 1000 --app-name="volume" ;;
      *)
      notify-send "  $vol%" -i none -h int:value:$vol -h string:synchronous:volume -t 1000 --app-name="volume" ;;
    esac
  '';
  set-brightness = pkgs.writeShellScriptBin "set-brightness" ''
    case $1 in
      "up")
        brightnessctl -q set 5%+;;
      "down")
        brightnessctl -q set 5%-;;
    esac

    brightness=$(($(brightnessctl g)*100/120000))
    notify-send "  $brightness%" -i none -h int:value:$brightness -h string:synchronous:brightness -t 1000 --app-name="brightness"
  '';
in

  {
    home.packages = [
      i3-floating-decor
      set-volume
      set-brightness
    ];

  }
