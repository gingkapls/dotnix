{ pkgs }: 

let
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
in
  pkgs.writeShellScriptBin "switch-theme" ''

    export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
    active="$(gsettings get org.gnome.desktop.interface color-scheme)"

    if [ "$active" = "'prefer-dark'" ]; then
        scheme="'prefer-light'"
        theme="Adwaita"
        printf "\nDark\nToggle" 
    else
        scheme="'prefer-dark'"
        theme="Adwaita-dark"
        printf "\nLight\nToggle"
    fi
    $1 gsettings set org.gnome.desktop.interface color-scheme "$scheme"
    $1 gsettings set org.gnome.desktop.interface gtk-theme "$theme"
    pkill -RTMIN+14 waybar
  ''
