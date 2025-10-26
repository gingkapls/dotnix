{ pkgs }: 

pkgs.writeShellScriptBin "dls" ''
    ${pkgs.spotdl}/bin/spotdl --max-retries 5 --output "$MUSIC_DIR/{artist}/{album}/{track-number} - {title}.{output-ext}" "$1"
 ''
