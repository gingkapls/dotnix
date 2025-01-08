{ lib, pkgs, ... }:

{
  fonts = {
    packages = lib.attrValues {
      inherit (pkgs)
      cm_unicode
      comic-mono
      cozette
      fira-code
      font-awesome
      gohufont
      ibm-plex
      inter
      iosevka
      lmmath
      material-icons
      merriweather
      merriweather-sans
      noto-fonts
      noto-fonts-cjk-sans
      paratype-pt-serif
      scientifica
      siji
      input-fonts
      twitter-color-emoji;
      };

    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;

      defaultFonts = {
        serif = [ "New York" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Input Mono"];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
