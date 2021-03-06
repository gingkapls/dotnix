{ config, lib, nix-colors, ... }:

with config.colorscheme.colors;
{
  home.file."README-md" = {
    target = "${config.xdg.cacheHome}/README.md";
    onChange = "cp -f '${config.home.file."README-md".target}' '${config.home.homeDirectory}/.dotnix/README.md'";
    
    text = ''
      # Welcome traveller to the disarray that are my dotfiles!

      ## Credits
      - [gammons/base16-obsidian](https://github.com/gammons/base16-obsidian)
      - [Misterio77/nix-colors](https://github.com/Misterio77/nix-colors)
      - [Misterio77/nix-starter-config](https://github.com/Misterio77/nix-starter-config/blob/minimal/configuration.nix)
      - [fortuneteller2k/nix-config](https://github.com/fortuneteller2k/nix-config)
      - [legendofmiracles/dotnix](https://github.com/legendofmiracles/dotnix)
      - [nuxshed/dotfiles](https://github.com/nuxshed/dotfiles)
      - [viperML/dotfiles](https://github.com/viperML/dotfiles)
      
      ![My rice!](./assets/rice.png "My rice!")
      
      |                     |                                                                                                               |
      | ------------------- | ------------------------------------------------------------------------------------------------------------- |
      | OS                  | [NixOS 21.11](https://nixos.org/)                                                                             |
      | Window Manager      | [Sway](https://github.com/swaywm/sway/) [i3-gaps](https://github.com/Airblader/i3)                            |
      | GTK Theme           | [Materia ${config.colorscheme.name}](https://github.com/Misterio77/nix-colors)                                |
      | Icon Theme          | [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)                                       |
      | Cusor Theme         | [Capitaine Cursors](https://github.com/keeferrourke/capitaine-cursors)                                        |
      | UI Font             | [Inter](https://github.com/rsms/inter)                                                                        | 
      | Terminal            | [Foot](https://codeberg.org/dnkl/foot) [Alacritty](https://github.com/alacritty/alacritty)                    |
      | Terminal Font       | [IBM Plex Mono](https://github.com/IBM/plex)                                                                |
      | PDF Viewer          | [Zathura](https://git.pwmt.org/pwmt/zathura)                                                                  |
      | Editor              | [Neovim](https://neovim.io/)                                                                                  |
      | Shell               | [Zsh](https://www.zsh.org/)                                                                                   |
      | Wallpaper           | [Wallpaper](./assets/wallpaper.png)                                                                           |
      | Colorscheme         | [${config.colorscheme.name}](https://github.com/savq/melange)                                                         |

      ## Color Palette
      |                                Colorscheme                                |                               ${config.colorscheme.name}                                     |
      |---------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
      | ![#${base00}](https://via.placeholder.com/15/${base00}/000000?text=+) `#${base00}` | ![#${base08}](https://via.placeholder.com/15/${base08}/000000?text=+) `#${base08}`  |
      | ![#${base01}](https://via.placeholder.com/15/${base01}/000000?text=+) `#${base01}` | ![#${base09}](https://via.placeholder.com/15/${base09}/000000?text=+) `#${base09}`  |
      | ![#${base02}](https://via.placeholder.com/15/${base02}/000000?text=+) `#${base02}` | ![#${base0A}](https://via.placeholder.com/15/${base0A}/000000?text=+) `#${base0A}`  |
      | ![#${base03}](https://via.placeholder.com/15/${base03}/000000?text=+) `#${base03}` | ![#${base0B}](https://via.placeholder.com/15/${base0B}/000000?text=+) `#${base0B}`  |
      | ![#${base04}](https://via.placeholder.com/15/${base04}/000000?text=+) `#${base04}` | ![#${base0C}](https://via.placeholder.com/15/${base0C}/000000?text=+) `#${base0C}`  |
      | ![#${base05}](https://via.placeholder.com/15/${base05}/000000?text=+) `#${base05}` | ![#${base0D}](https://via.placeholder.com/15/${base0D}/000000?text=+) `#${base0D}`  |
      | ![#${base06}](https://via.placeholder.com/15/${base06}/000000?text=+) `#${base06}` | ![#${base0E}](https://via.placeholder.com/15/${base0E}/000000?text=+) `#${base0E}`  |
      | ![#${base07}](https://via.placeholder.com/15/${base07}/000000?text=+) `#${base07}` | ![#${base0F}](https://via.placeholder.com/15/${base0F}/000000?text=+) `#${base0F}`  |
      '';
  };

  #home.activation = {
  #  generateReadme = lib.hm.dag.entryAfter [ "home.file.README.md" ] ''
  #    cp -f "${config.xdg.cacheHome}/README.md" "${config.home.homeDirectory}/.dotnix/README.md"
  #  '';
  #};

}

