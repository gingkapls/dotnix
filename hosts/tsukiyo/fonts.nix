{ lib, pkgs, ... }:

{
  fonts = {
    packages = lib.attrValues {
      inherit (pkgs)
      # apple-fonts
      noto-fonts
      noto-fonts-cjk
      inter
      iosevka
      ibm-plex
      fira-code
      scientifica
      siji
      # twemoji-color-font
      twitter-color-emoji
      paratype-pt-serif
      material-icons
      merriweather
      merriweather-sans
      font-awesome
      comic-mono
      lmmath
      cm_unicode;
    };

    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;

      defaultFonts = {
        serif = [ "New York" ];
        sansSerif = [ "SF Pro Display" ];
        monospace = [ "Comic Mono"];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
