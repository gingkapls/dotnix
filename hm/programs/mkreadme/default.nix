{ config, lib, nix-colors, ... }:

let
  colors = config.colorscheme.colors;
#  fonts = osConfig.fonts.fontconfig.defaultFonts;
in {
  home.file."README-md" = {
    target = "${config.xdg.cacheHome}/README.md";
    onChange = "cp -f '${config.home.file."README-md".target}' '${config.home.homeDirectory}/.dotnix/README.md'";
    
    text = ''
      ## welcome to this mess and stuff
      thansk <3

      ## Sway Rice
      ![sway rice](./assets/sway-rice.png "sway rice")

      ## shameless macos clone
      ![gnome rice](./assets/gnome-rice.png "gnome rice")
      
      |                     |                                                                           |
      | ------------------- | ------------------------------------------------------------------------- |
      | OS                  | NixOS 23.05                                                               |
      | Window Manager      | Sway / i3-gaps                                                            |
      | Desktop Environment | Gnome                                                                     |
      | GTK Theme           | ${config.gtk.theme.name}                                                  |
      | Icon Theme          | ${config.gtk.iconTheme.name}                                              |
      | Cusor Theme         | ${config.home.pointerCursor.name}                                         |
      | UI Font             |                                           |
      | Terminal            | Foot / Alacritty / Blackbox                                               |
      | Terminal Font       |                                           |
      | PDF Viewer          | Zathura / Evince                                                          |
      | Editor              | Neovim / Helix                                                            |
      | Shell               | Zsh                                                                       |
      | Wallpaper           | [Wallpaper](./assets/wallpaper.png)                                       |
      | Colorscheme         | ${config.colorscheme.name}                                                |

      ## Color Palette
      |                    Colorscheme                       |              ${config.colorscheme.name}               |
      |:----------------------------------------------------:|:-----------------------------------------------------:|
      | $$\textcolor{#${colors.base00}}{\text{████}}$$ `#${colors.base00}` |  $$\textcolor{#${colors.base08}}{\text{████}}$$ `#${colors.base08}` |
      | $$\textcolor{#${colors.base01}}{\text{████}}$$ `#${colors.base01}` |  $$\textcolor{#${colors.base09}}{\text{████}}$$ `#${colors.base09}` |
      | $$\textcolor{#${colors.base02}}{\text{████}}$$ `#${colors.base02}` |  $$\textcolor{#${colors.base0A}}{\text{████}}$$ `#${colors.base0A}` |
      | $$\textcolor{#${colors.base03}}{\text{████}}$$ `#${colors.base03}` |  $$\textcolor{#${colors.base0B}}{\text{████}}$$ `#${colors.base0B}` |
      | $$\textcolor{#${colors.base04}}{\text{████}}$$ `#${colors.base04}` |  $$\textcolor{#${colors.base0C}}{\text{████}}$$ `#${colors.base0C}` |
      | $$\textcolor{#${colors.base05}}{\text{████}}$$ `#${colors.base05}` |  $$\textcolor{#${colors.base0D}}{\text{████}}$$ `#${colors.base0D}` |
      | $$\textcolor{#${colors.base06}}{\text{████}}$$ `#${colors.base06}` |  $$\textcolor{#${colors.base0E}}{\text{████}}$$ `#${colors.base0E}` |
      | $$\textcolor{#${colors.base07}}{\text{████}}$$ `#${colors.base07}` |  $$\textcolor{#${colors.base0F}}{\text{████}}$$ `#${colors.base0F}` |
      
      ## Credits
      - [gammons/base16-obsidian](https://github.com/gammons/base16-obsidian)
      - [Misterio77/nix-colors](https://github.com/Misterio77/nix-colors)
      - [Misterio77/nix-starter-config](https://github.com/Misterio77/nix-starter-config/blob/minimal/configuration.nix)
      - [fortuneteller2k/nix-config](https://github.com/fortuneteller2k/nix-config)
      - [legendofmiracles/dotnix](https://github.com/legendofmiracles/dotnix)
      - [nuxshed/dotfiles](https://github.com/nuxshed/dotfiles)
      - [viperML/dotfiles](https://github.com/viperML/dotfiles)
      '';
  };

  #home.activation = {
  #  generateReadme = lib.hm.dag.entryAfter [ "home.file.README.md" ] ''
  #    cp -f "${config.xdg.cacheHome}/README.md" "${config.home.homeDirectory}/.dotnix/README.md"
  #  '';
  #};

}

