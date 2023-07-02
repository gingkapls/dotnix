{ lib, pkgs, ... }:

{
  fonts = {
    fonts = lib.attrValues {
      inherit (pkgs)
      noto-fonts
      noto-fonts-cjk
      inter
      iosevka
      # ibm-plex
      # fira-code
      # scientifica
      # siji
      twemoji-color-font
      paratype-pt-serif
      material-icons
      merriweather
      merriweather-sans
      font-awesome
      lmmath
      cm_unicode;
    };

    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;

      defaultFonts = {
        serif = [ "Pt Serif" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Iosevka"];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
