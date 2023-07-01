{ pkgs }:

pkgs.writeShellScriptBin "meme-menu" ''
  memeDir="$HOME/Pictures/Memes"
  meme="$(ls "$memeDir" | ${pkgs.bemenu}/bin/bemenu -i "''${BEMENU_OPTS}")"
  if [ ! -z $meme ]; then
    xclip -t image/png -selection clipboard "$memeDir/$meme"
  else
    false
  fi
''
