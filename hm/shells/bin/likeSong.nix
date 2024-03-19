{ pkgs }:

pkgs.writeShellScriptBin "likeSong" ''
  songList="$HOME/Music/likedsongs"
  lastSong=$(tail -n1 $songList)
  curSong=$(${pkgs.playerctl}/bin/playerctl metadata -f "{{artist}} - {{title}} ({{album}})")

  ${pkgs.libnotify}/bin/notify-send "Added $curSong to liked songs"

  if [[ $lastSong != $curSong ]] then
    echo "$curSong" >> "$songList"
  fi
''


