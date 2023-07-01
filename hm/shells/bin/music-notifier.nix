{ pkgs }:

pkgs.writeShellScriptBin "music-notifier" ''
  for pid in $(pidof -x music-notifier); do
      if [ $pid != $$ ]; then
          kill -9 $pid
      fi 
  done >/dev/null

  killall -9 playerctl 2>/dev/null

  IFS='`' # good enough

  exec ${pkgs.playerctl}/bin/playerctl -Fsp playerctld metadata -f '{{status}}`{{title}}`{{artist}}`{{album}}`{{mpris:artUrl}}' | sed -u "s/&/and/g; s/\"/\'/g" | while read -r playing title artist album art; do # & -> and to fix pango funky

  # printf "%s\n%s\n%s\n%s\n%s\n" "$playing" "$title" "$artist" "$album" "$art";
  printf '{"class": "%s", "text": "%s", "alt": "%s", "tooltip": "%s // %s"}\n' "$playing" "''${title}" "$playing" "$artist" "$album"

  # printf '{"class": "%s", "text": "%s", "alt": "%s", "tooltip": "%s // %s"}\n' "$playing" "''${title%%-*}" "$playing" "$artist" "$album"
  # Shorten long titles to first hyphen
 
    [ ! -z "$art" ] && ${pkgs.libnotify}/bin/notify-send "''${title}" "''${artist%%,*}" --expire-time "2000" --app-name "music-notifier" --icon "$art"; # Avoid multiple notifications due to missing album art

    # [ ! -z "$art" ] && ${pkgs.libnotify}/bin/notify-send "''${title%%-*}" "\n''${artist%%,*} //\n$album" --expire-time "2000" --app-name "music-notifier" --icon "$art"; # Avoid multiple notifications due to missing album art
  done
''
