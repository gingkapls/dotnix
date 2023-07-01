{ config, pkgs, libs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      gin = {
        isDefault = true;
        # userChrome = builtins.readFile ./userChrome.nix;
        settings = 
          let
            # fonts = osConfig.fonts.fontconfig.defaultFonts;
          in {
          # Customizations
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Fonts
          # "font.name.monospace.x-western" = builtins.toString fonts.monospace;
          # "font.name.sans-serif.x-western" = builtins.toString fonts.sansSerif;
          # "font.name.serif.x-western" = builtins.toString fonts.serif;

          # turn of google safebrowsing (it literally sends a sha sum of everything you download to google)
          "browser.safebrowsing.downloads.remote.block_dangerous" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.downloads.remote.url" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;


          # telemetry
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;

          # experiments
          "experiments.supported" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";

          "browser.discovery.enabled" = false;
          "extensions.shield-recipe-client.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "loop.logDomains" = false;

          # iirc hides pocket stories
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

          # third party cookies
          "network.cookie.cookieBehavior" = 1;

          # default browser
          "browser.shell.checkDefaultBrowser" = false;

          # download location
          "browser.download.dir" = "${config.home.homeDirectory}/Downloads";
          "browser.download.folderList" = 2;

          # webbrender
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };

    };
  
  };

}
