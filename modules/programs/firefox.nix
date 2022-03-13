{ config, pkgs, libs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      gin = {
        isDefault = true;
        settings = {
          # Customizations
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Fonts
          "font.name.monospace.x-western" = "Iosevka";
          "font.name.sans-serif.x-western" = "Inter";
          "font.name.serif.x-western" = "Pt Serif";

          # turn of google safebrowsing (it literally sends a sha sum of everything you download to google)
          "browser.safebrowsing.downloads.remote.block_dangerous" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" =
            false;
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
          "browser.download.dir" = "/home/gin/Downloads";
          "browser.download.folderList" = 2;

          # webbrender
          "gfx.webrender.all" = true;
        };

        userChrome = ''
          /* Sidebar min and max width removal */
          #sidebar {
              max-width: none !important;
              min-width: 0px !important;
          }
          /* Hide splitter */
          #sidebar-box + #sidebar-splitter {
              display: none !important;
          }
          /* Hide sidebar header */
          #sidebar-box #sidebar-header {
              visibility: collapse;
          }

          #main-window #TabsToolbar {
            height: 40px !important;
            overflow: hidden;
            transition: height .3s .3s !important;
          }
          
          #main-window[titlepreface*="Sideberry"] #TabsToolbar {
            height: 0 !important;
          }
          #main-window[titlepreface*="Sideberry"] #tabbrowser-tabs {
            z-index: 0 !important;
          }

          #sidebar #sidebar-search-container {
           display:none!important;
          }
          
          /* Shrink sidebar until hovered */
          :root {
              --thin-tab-width: 80px;
              --wide-tab-width: 300px;
          }
          
          #sidebar-box {
              position: relative !important;
              transition: all 5000ms !important;
              min-width: var(--thin-tab-width) !important;
              max-width: var(--thin-tab-width) !important;
          }
          #sidebar-box:hover {
              transition: all 200ms !important;
              transition-delay: 0.2s !important;
              min-width: var(--wide-tab-width) !important;
              max-width: var(--wide-tab-width) !important;
              margin-right: calc((var(--wide-tab-width) - var(--thin-tab-width)) * -1) !important;
              z-index: 1;
          }
        '';
      };

    };
  
  };

}
