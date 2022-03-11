{ config, nix-colors, ... }:

with config.colorscheme.colors;
{
  xdg.configFile."swaylock/config".text = ''
    image="${config.home.homeDirectory}/.dotnix/assets/wallpaper.png"
    scaling=fill

    bs-hl-color=${base09}
    caps-lock-bs-hl-color=${base0B}
    caps-lock-key-hl-color=${base09}

    inside-color=${base00}
    inside-clear-color=${base01}
    inside-caps-lock-color=${base00}
    inside-ver-color=${base0B}
    inside-wrong-color=${base08}
    key-hl-color=${base05}

    layout-bg-color=${base00}
    layout-border-color=${base03}
    layout-text-color=${base05}

    line-color=${base00}
    line-clear-color=${base00}
    line-caps-lock-color=${base09}
    line-ver-color=${base00}
    line-wrong-color=${base08}

    ring-color=${base00}
    ring-clear-color=${base00}
    ring-caps-lock-color=${base08}
    ring-ver-color=${base07}
    ring-wrong-color=${base08}
    separator-color=${base00}
    indicator-radius=100
    indicator-thickness=5

    text-color=${base05}
    text-clear-color=${base00}
    text-ver-color=${base07}
    text-wrong-color=${base08}
  '';
}
