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
          "font.name.monospace.x-western" = font;
          "font.name.sans-serif.x-western" = font;
          "font.name.serif.x-western" = font;

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
          #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
            opacity: 0;
            pointer-events: none;
          }
          #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
              visibility: collapse !important;
          }
          
          
          /* Hide main tabs toolbar */
          #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
              opacity: 0;
              pointer-events: none;
          }
          #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
              visibility: collapse !important;
          }
          
          /* Sidebar min and max width removal */
          #sidebar {
              max-width: none !important;
              min-width: 0px !important;
          }
          /* Hide splitter, when using Tree Style Tab. */
          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] + #sidebar-splitter {
              display: none !important;
          }
          /* Hide sidebar header, when using Tree Style Tab. */
          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
              visibility: collapse;
          }
          
          /* Shrink sidebar until hovered, when using Tree Style Tab. */
          :root {
              --thin-tab-width: 60px;
              --wide-tab-width: 300px;
          }
          #sidebar-box:not([sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"]) {
              min-width: var(--wide-tab-width) !important;
              max-width: none !important;
          }
          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] {
              position: relative !important;
              transition: all 100ms !important;
              min-width: var(--thin-tab-width) !important;
              max-width: var(--thin-tab-width) !important;
          }
          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"]:hover {
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
