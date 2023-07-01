{ config, nix-colors, ... }:

with config.colorscheme.colors;
{
  home.file."Obsidian-base16-default" = {
    target = "${config.home.homeDirectory}/Documents/Obsidian/.obsidian/themes/base16-default.css";
    text = 
    ''
      /* Credits to @gammons */
      /* https://github.com/gammons/base16-obsidian /*
      /* Colorscheme: ${config.colorscheme.name} */


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
    
      /*************************
       * Font selection
      *************************/
      
      .workspace {
        font-family: var(--font-family-editor);
      }
      
      .markdown-preview-view {
        font-family: var(--font-family-preview) !important;
      }
      
      /*************************
       * workspace
      *************************/
      
      .workspace {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }
      
      .workspace-tabs {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }
      
      .workspace-tab-header {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }
      
      .workspace-tab-header-inner {
        color: var(--base02) !important;
      }
      
      .workspace-leaf {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }
      
      /*************************
       * View header
      *************************/
      
      .view-header {
        background-color: var(--base00) !important;
        color: var(--base06) !important;
        border-bottom: 1px solid var(--base01);
      }
      
      .view-header-title {
        color: var(--base06) !important;
      }
      
      .view-header-title-container:after {
        background: none !important;
      }
      
      .view-content {
        background-color: var(--base00) !important;
        color: var(--base06) !important;
      }
      
      .view-action {
        color: var(--base06) !important;
      }
      
      /*************************
       * Nav folder
      *************************/
      
      .nav-folder-title, .nav-file-title {
        background-color: var(--base00) !important;
        color: var(--base06) !important;
      }
      
      .nav-action-button {
        color: var(--base06) !important;
      }
      
      /*************************
       * Markdown headers
      *************************/
      
      .cm-header-1, .markdown-preview-view h1 {
        color: var(--base0A);
      }
      
      .cm-header-2, .markdown-preview-view h2 {
        color: var(--base0B);
      }
      
      .cm-header-3, .markdown-preview-view h3 {
        color: var(--base0C);
      }
      
      .cm-header-4, .markdown-preview-view h4 {
        color: var(--base0D);
      }
      
      .cm-header-5, .markdown-preview-view h5 {
        color: var(--base0E);
      }
      
      .cm-header-6, .markdown-preview-view h6 {
        color: var(--base0E);
      }
      
      /*************************
       * Markdown strong and emphasis
      *************************/
      
      .cm-em, .markdown-preview-view em {
        color: var(--base0D);
      }
      
      .cm-strong, .markdown-preview-view strong {
        color: var(--base09);
      }
      
      /*************************
       * Markdown links
      *************************/
      
      .cm-link, .markdown-preview-view a {
        color: var(--base0C) !important;
      }
      
      .cm-formatting-link,.cm-url {
        color: var(--base03) !important;
      }
      
      /*************************
       * Quotes
      *************************/
      
      .cm-quote, .markdown-preview-view blockquote {
        color: var(--base0D) !important;
      }
      
      /*************************
       * Code blocks
      *************************/
      
      .HyperMD-codeblock, .markdown-preview-view pre {
        color: var(--base07) !important;
        background-color: var(--base01) !important;
      }
      
      .cm-inline-code, .markdown-preview-view code {
        color: var(--base07) !important;
        background-color: var(--base01) !important;
      }
      
      /*************************
       * Cursor
      *************************/
      
      .CodeMirror-cursors {
        color: var(--base0B);
        z-index: 5 !important /* fixes a bug where cursor is hidden in code blocks */
      }
    '';
  };

}
