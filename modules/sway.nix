{ config, ... } :

{
  programs.sway = {
    enable = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };

    extraOptions = [
      "--unsupported-gpu"
    ];

    extraSessionCommands = ''
      export XDG_SESSION_DESKTOP=sway
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export MOZ_ENABLE_WAYLAND=1
      export MOZ_DISABLE_RDD_SANDBOX=1
      export CLUTTER_BACKEND=wayland
      export ECORE_EVAS_ENGINE=wayland-egl
      export ELM_ENGINE=wayland_egl
      export NO_AT_BRIDGE=1
      export _JAVA_AWT_WM_NONREPARENTING=1
      '';
  };
}
