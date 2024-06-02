{ config, lib, pkgs, ... }:


with lib;
let cfg = config.modules.desktop.windowManager.hyprland;
in {
  options.modules.desktop.windowManager.hyprland = {
    enable = mkEnableOption "Enable Hyprland wayland compositor";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaynotificationcenter
      wl-clipboard
      mako
      bemenu
      slurp
      swappy
      grim
      wf-recorder
    ];


    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
        "$super_mod" = "SUPER_SHIFT";
        "exec-once" = "foot --server";
        "monitor" = "eDP-1, 1920x1080@60.03, 0x0, 1";
        
        bind =
          [
            "$mod, F, exec, firefox"
            "$mod, Return, exec, footclient"
            "$mod, Q, killactive,"
            "$mod, M, fullscreen,"
            "$mod, h, movefocus, l"
            "$mod, j, movefocus, d"
            "$mod, k, movefocus, u"
            "$mod, l, movefocus, r"

            "$super_mod, h, movewindow, l"
            "$super_mod, j, movewindow, d"
            "$super_mod, k, movewindow, u"
            "$super_mod, l, movewindow, r"

            ", Print, exec, grim copy area"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList
              (
                x:
                let
                  ws =
                    let
                      c = (x + 1) / 10;
                    in
                    builtins.toString (x + 1 - (c * 10));
                in
                [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );
      };
    };
  };
}
