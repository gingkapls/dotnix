{ config, nix-colors, ... }:

with config.colorscheme.colors;
{
  home.file."Obsidian-base16-arsmagna" = {
    target = "${config.home.homeDirectory}/Documents/Obsidian/.obsidian/themes/base16-arsmagna.css";
    text = 
      ''
        /*====================_Ars Magna Lucis et Umbrae_===================*/
        /* 2020-06-28 Theme by @mediapathic, but honestly mostly composed of bits from @death_au and @cotemaxime, */
        /* and a few other fragments here and there.  */
        /* Colorscheme: ${config.colorscheme.name} */
        
        
        /* font */
        
        :root {
          --base00: #${base00};
          --base01: #${base01};
          --base02: #${base02};
          --base03: #${base03};
          --base04: #${base04};
          --base05: #${base05};
          --base06: #${base06};
          --base07: #${base07};
          --base08: #${base08};
          --base09: #${base09};
          --base0A: #${base0A};
          --base0B: #${base0B};
          --base0C: #${base0C};
          --base0D: #${base0D};
          --base0E: #${base0E};
          --base0F: #${base0F};
        }
        
        body {
          /* font stacks taken directly from Notion */
          font-family: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, "Apple Color Emoji", Arial, sans-serif, "Segoe UI Emoji", "Segoe UI Symbol";
          --font-monospace: "Iosevka Medium", "SFMono-Regular", Consolas, "Liberation Mono", Menlo, Courier, monospace;
        
          -webkit-font-smoothing: auto;
        }
        
        body.theme-light, body.theme-dark {
        /* Disable unused variables
          --text-highlight-bg:          var(--base02 );
          --text-selection:             var(--base07);
        */
          --interactive-normal:         var(--base01);
          --interactive-hover:          var(--base03);
          --GText:                      var(--base05);
          --GFill:                      var(--base0F);
          --GLine:                      var(--base0F);
          --background-primary:         var(--base00);
          --background-primary-alt:     var(--base00); 
          --background-secondary:       var(--base01); 
          --background-secondary-alt:   var(--base00); 
          --background-accent:          var(--base01); 
          --background-modifier-border: var(--base01);  
          --external-link:              var(--base09);
          --internal-link:              var(--base0E);
          --text-accent:                var(--base05);
          --text-accent-hover:          var(--base03);
          --text-normal:                var(--base05);
        /*  --text-muted:                 rgba(var(--text-rgb), 0.45); /* subtle mode */
          --text-muted:                 var(--base03);        /* Full Pulp */
          --text-faint:                 var(--base03);
          --text-on-accent:             var(--base01);
          --interactive-accent:         var(--base04);
          --interactive-accent-hover:   var(--base04);
        }
        
        /* Fix font weights */
        .view-header-title {
          font-weight: 700;
        }
        
        h1, h2, h3, h4, h5, h6, strong, .cm-s-obsidian .cm-header {
          font-weight: 600;
        }
        
        /* headings */
        .markdown-preview-view h1{
          font-size: 30px;
          margin-top: 32px;
          margin-bottom: 4px;
        }
        .markdown-preview-view h2{
          font-size: 24px;
          margin-top: 23px;
          margin-bottom: 1px;
        }
        .markdown-preview-view h3,
        .markdown-preview-view h4,
        .markdown-preview-view h5,
        .markdown-preview-view h6{
            font-size: 20px;
            margin-top: 16px;
            margin-bottom: 0px;
        }
        
        .cm-s-obsidian .cm-header-1 { font-size: 30px; }
        .cm-s-obsidian .cm-header-2 { font-size: 24px; }
        .cm-s-obsidian .cm-header-3,
        .cm-s-obsidian .cm-header-4,
        .cm-s-obsidian .cm-header-5,
        .cm-s-obsidian .cm-header-6{ font-size: 20px; }
        .cm-s-obsidian .cm-header-6 { color: var(--text-muted); }
        
        /* links */
        .external-link {
          background-image: none; /* no external link indicator */
          padding:0;
          color: var(--external-link);
        }
        
        .markdown-preview-view .internal-link, .popover.hover-popover .markdown-embed .internal-link {
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;
          font-weight: 500;
          line-height: 1.3;
          border-bottom: 1px solid var(--background-modifier-border);
          color: var(--internal-link);
          text-decoration: none;
        }
        
        /* Nifty SVG arrow before internal links */
        /* Also applies to embeds */
        .internal-link::before, .markdown-embed-link::before {
          content: " ";
          background-color: var(--text-normal);
          -webkit-mask-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3E%3Cpolygon points='5.4 26 24 7.4 24 20 26 20 26 4 10 4 10 6 22.6 6 4 24.6'%3E%3C/polygon%3E%3C/svg%3E");
          display: inline-block;
          width: 1em;
          height: 1em;
          margin-right: 4px;
        }
        
        /* embeds (mimics embedded tables from Notion) */
        .markdown-embed-title {
          font-size: 1.25em;
          line-height: 1.5;
          font-weight: 600;
          text-align: left;
        }
        
        .markdown-preview-view .markdown-embed {
          border:none;
          margin:0;
          border-bottom: 1px solid var(--background-modifier-border);
          border-radius: 0;
        }
        
        .markdown-embed-link {
          color: var(--text-normal);
          right:unset;
          left: 0;
          height: 30px;
          width: calc(100% - 20px);
          margin-left: 4px;
          border-bottom: 1px solid var(--background-modifier-border);
        }
        
        .markdown-embed-link::before {
          font-size: 0.8em;
        }
        
        .markdown-embed-link svg {
          display: none; /* hide the svg link icon, gets replaced with a nifty arrow */
        }
        
        /* table headers and first column styling */
        .markdown-preview-view th:first-child, .markdown-preview-view td:first-child {
          border-left: none;
        }
        .markdown-preview-view th:last-child, .markdown-preview-view td:last-child {
          border-right: none;
        }
        
        .markdown-preview-view th {
          text-align: left;
          font-weight: normal;
          color: var(--text-muted);
        }
        
        .markdown-preview-view td:first-child {
          font-weight: 600;
        }
        
        .markdown-preview-view hr {
          height: 1px;
          opacity: 0.5;
        }
        
        /* popover fixes */
        .popover.hover-popover .markdown-embed-link {
          border-bottom: none;
        }
        
        /* task lists! */
        .markdown-preview-view .task-list-item-checkbox {
          -webkit-appearance: none;
          box-sizing: border-box;
          border: 1px solid var(--text-normal);
          border-radius: 2px;
          position: relative;
          width: 1em;
          height: 1em;
          margin: 0;
          margin-right: 4px;
          margin-bottom: 2px;
          transition: background-color 0.3s ease;
          cursor: pointer;
        }
        .markdown-preview-view .task-list-item-checkbox:checked {
          border:none;
          background-color: var(--interactive-accent);
        }
        .markdown-preview-view .task-list-item-checkbox:hover {
          background-color: var(--background-primary-alt);
        }
        /* the SVG check mark */
        .markdown-preview-view .task-list-item-checkbox:checked::before {
          content: ' ';
          position: absolute;
          background-color: var(--background-secondary);
          left:1px;
          top:1px;
          right:1px;
          bottom:1px;
          -webkit-mask-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 14 14'%3E%3Cpolygon points='5.5 11.9993304 14 3.49933039 12.5 2 5.5 8.99933039 1.5 4.9968652 0 6.49933039'%3E%3C/polygon%3E%3C/svg%3E");
        }
        
        /* this should strike through checked off items, once CSS supports :has
          (it's draft right now) */
        .markdown-preview-view .task-list-item:has(.task-list-item-checkbox:checked) {
          text-decoration: line-through;
          color: var(--text-muted);
        }
        
        .markdown-preview-view .task-list-item {
          margin-left: -40px;
        }
        
        /* Blockquotes */
        .markdown-preview-view blockquote, .cm-s-obsidian pre.HyperMD-quote-1 {
          border:none;
          border-left: 3px solid currentcolor;
        }
        
        /* for some reason messing with the padding and size like this caused weirdness
          with the editor mode cursor position. So just preview for now */
        .markdown-preview-view blockquote {
          padding: 0 0.9em;
          font-size: 1.2em;
          margin: 3px 2px;
        }
        
        /* code */
        .markdown-preview-view code, .cm-s-obsidian span.cm-inline-code, .cm-s-obsidian pre.HyperMD-codeblock {
          color: var(--code);
          font-family: var(--font-monospace);
        }
        
        /* escape character */
        .cm-s-obsidian span.cm-hmd-escape-backslash {
          color: var(--text-faint);
        }
        
        /* highlight */
        .markdown-preview-view mark {
          color: var(--text-normal);
        }
        
        /* bulleted lists */
        ul {
          list-style-type: disc;
          padding-inline-start: 40px;
        }
        ul ul {
          padding-inline-start: 60px;
        }
        
        /* graph view colours */
        .graph-view.color-fill {
          color: var(--GFill);
        }
        .graph-view.color-line {
          color: var(--GLine);
        }
        .graph-view.color-text {
          color: var(--GText);
        }
        .graph-view.color-fill-highlight {
          color: var(--interactive-accent);
        }
        .graph-view.color-line-highlight {
          color: var(--interactive-accent);
        }
        
        /* misc fixes */
        .cm-s-obsidian span.cm-quote {
          color: var(--text-normal);
        }
        
        /* Andy Matuschak mode! V2! for 0.7.0! (so... 2.7?) I think by @cotemaxime and @death_au, I certainly can't claim any of it */
        
        /* everything under .mod-root now. Don't want Andy messing with sidebars */
        /* also, Andy only makes sense for vertical splits, at the root level, right? */
        .mod-root.workspace-split.mod-vertical {
          overflow-x:auto;
          --header-width: 36px; /* <- 36px is the header height in the default theme */
        }
        .mod-root.workspace-split.mod-vertical > div {
          min-width: calc(700px + var(--header-width)); /* <-- 700px is the default theme's "readable" max-width */
          box-shadow: 0px 0px 20px 20px rgba(0,0,0,0.25);
          position:sticky;
          left:0;
        }
        
        /* shift sticky position, so titles will stack up to the left */
        /* This will currently stack to a maximum of 10 before resetting */
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-8) { left: calc(var(--header-width) * 0); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-7) { left: calc(var(--header-width) * 1); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-6) { left: calc(var(--header-width) * 2); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-5) { left: calc(var(--header-width) * 3); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-4) { left: calc(var(--header-width) * 4); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-3) { left: calc(var(--header-width) * 5); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-2) { left: calc(var(--header-width) * 6); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n-1) { left: calc(var(--header-width) * 7); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n+0) { left: calc(var(--header-width) * 8); }
        .mod-root.workspace-split.mod-vertical > div:nth-child(10n+1) { left: calc(var(--header-width) * 9); }
        
        /* now it's time for the fancy vertical titles */
        
        /* first we'll add a bit of gap for the title to sit inside of */
        .workspace-leaf-content {
          padding-left: var(--header-width);
          position: relative;
        }
        
        /* this is where the magic happens */
        .view-header {
          writing-mode: vertical-lr;
          border-right: 1px solid var(--background-secondary-alt);
          border-left: 2px solid var(--background-secondary-alt);
          border-top: none;
          border-bottom: none;
          height: auto;
          width: var(--header-width);
          position: absolute;
          left:0;
          top:0;
          bottom:0;
        }
        
        /* active titles have different border colours */
        .workspace-leaf.mod-active .view-header {
          border-right: 2px solid var(--interactive-accent);
          border-bottom: none;
        }
        
        /* unset the title container height and swap padding */
        .view-header-title-container {
          height: unset;
          padding-left: unset;
          padding-top: 5px;
        }
        
        /* fix the long-title-obscuring shadows */
        .view-header-title-container:after {
          width: 100%;
          height: 30px;
          top:unset;
          bottom: 0;
          background: linear-gradient(to bottom, transparent, var(--background-secondary));
        }
        .workspace-leaf.mod-active .view-header-title-container:after {
          background: linear-gradient(to bottom, transparent, var(--background-primary-alt));
        }
        
        /* swap the padding/margin around for the header and actions icons */
        .view-header-icon, .view-actions {
          padding: 10px 5px;
        }
        .view-action {
          margin: 8px 0;
        }
        
        /* get rid of the gap left by the now-missing horizontal title */
        .view-content {
          height: 100%;
        }
        
        /* make the fake drop target overlay have a background so you can see it. */
        /* TODO: figure out how the fake target overlay works so we can put the title back, too */
        .workspace-fake-target-overlay {
          background-color: var(--background-primary);
        }
        
        /* Auto-collapsing sidebars courtesy @kmaasrud */
        
        .app-container.is-left-sidedock-collapsed .side-dock.mod-left:not(:hover), .app-container.is-right-sidedock-collapsed .side-dock.mod-right:not(:hover) {
          width: 0px !important;
        }
        
        /* Naked Embeds */
        .markdown-embed-title { display:none; }
        .markdown-preview-view .markdown-embed { border:none; padding:0; margin:0; }
        .markdown-preview-view .markdown-embed-content { max-height: unset;}
        .markdown-preview-view .markdown-embed-content>:first-child { margin-top: 0; }
        .markdown-preview-view .markdown-embed-content>:last-child { margin-bottom: 0; }
        
        
        /* level indicators for bullet list */
        
        .cm-hmd-list-indent .cm-tab, ul ul { position: relative; }
        .cm-hmd-list-indent .cm-tab::before, ul ul::before {
          /* Escape the single quotes for Nix */
         content:''';
         border-left: 1px solid rgba(0, 122, 255, 0.25);
         position: absolute;
        }
        .cm-hmd-list-indent .cm-tab::before { left: 0; top: -5px; bottom: -4px;
        }
        ul ul::before { left: -11px; top: 0; bottom: 0;
        }
      '';
    };

}
