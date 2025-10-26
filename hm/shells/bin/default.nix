{ config, pkgs, ... }:

{
    home.packages = [
      (import ./dls.nix { inherit config pkgs; })
      (import ./hm.nix { inherit config pkgs; })
      (import ./i3-floating-decorations.nix { inherit pkgs; })
      (import ./likeSong.nix { inherit pkgs; })
      (import ./meme-menu.nix { inherit pkgs; })
      (import ./music-notifier.nix { inherit pkgs; })
      (import ./set-brightness.nix { inherit pkgs; })
      (import ./set-volume.nix { inherit pkgs; })
      (import ./switch-theme.nix { inherit pkgs; })
      (import ./wlrecord.nix { inherit pkgs; })
      (import ./wlshot.nix { inherit pkgs; })
      (import ./xshot.nix { inherit pkgs; })
    ];

}
