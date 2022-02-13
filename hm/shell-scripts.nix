{ pkgs, inputs, lib, ... }:

rec {
  i3-floating-decor = pkgs.writers.writePython3Bin "i3-floating-decor" { libraries = [ pkgs.Python3Packages.i3ipc ]; }
      ''
      import i3ipc
      
      i3 = i3ipc.Connection()
      
      def border_on_floating(i3, e):
          ws = i3.get_tree().find_focused().workspace()
          if (e.container.floating=='user_off'):
              e.container.command('border none')
          elif (e.container.floating=='user_on'):
              e.container.command('border normal')
      
      i3.on('window::floating', border_on_floating)
      
      i3.main()
      '';

  text_from_image = pkgs.writeShellScriptBin "ocr" ''
    TEXT_FILE="/tmp/ocr.txt"
    IMAGE_FILE="/tmp/ocr.png"
    ${pkgs.maim}/bin/maim -s "$IMAGE_FILE"
    STATUS=$?
    [ $STATUS -ne 0 ] && exit 1
    ${pkgs.tesseract}/bin/tesseract "$IMAGE_FILE" "''${TEXT_FILE//\.txt/}"
    LINES=$(wc -l < $TEXT_FILE)
    if [ "$LINES" -eq 0 ]; then
        ${pkgs.libnotify}/bin/notify-send "ocr" "no text was detected"
        exit 1
    fi
    xclip -selection clip < "$TEXT_FILE"
    ${pkgs.libnotify}/bin/notify-send "ocr" "$(cat $TEXT_FILE)"
    rm "$TEXT_FILE"
    rm "$IMAGE_FILE"
  '';

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  }
