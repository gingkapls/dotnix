{ config, lib, nix-colors, ... }:

with config.colorscheme.colors;
with config;
{
  home.file."README.md" = {
    target = "${xdg.cacheHome}/README.md";
    onChange = "cp -f '${home.file."README.md".target}' '${home.homeDirectory}/.dotnix/README.md'";
    
    text = ''
      ### Welcome traveller to the disarray that are my dotfiles!
      
      ![My rice!](./assets/rice.png "My rice!")
      
      |                     |                                                                                                               |
      | ------------------- | ------------------------------------------------------------------------------------------------------------- |
      | OS                  | [NixOS 21.11](https://nixos.org/)                                                                             |
      | Window Manager      | [Sway](https://github.com/swaywm/sway/) [i3-gaps](https://github.com/Airblader/i3)                            |
      | GTK Theme           | [Materia Nix-colors](https://github.com/Misterio77/nix-colors)                                                |
      | Icon Theme          | [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)                                       |
      | Cusor Theme         | [Capitaine Cursors](https://github.com/keeferrourke/capitaine-cursors)                                        |
      | UI Font             | [Inter](https://github.com/rsms/inter)                                                                        | 
      | Terminal            | [Foot](https://codeberg.org/dnkl/foot) [Alacritty](https://github.com/alacritty/alacritty)                    |
      | Terminal Font       | [Iosevka](https://github.com/be5invis/Iosevka)                                                                |
      | PDF Viewer          | [Zathura](https://git.pwmt.org/pwmt/zathura)                                                                  |
      | Editor              | [Neovim](https://neovim.io/)                                                                                  |
      | Shell               | [Zsh](https://www.zsh.org/)                                                                                   |
      | Wallpaper           | [Nodame Cantabile](./assets/wallpaper.png)                                                                    |
      | Colorscheme         | [Rosé Pine Dawn](https://github.com/rose-pine/)                                                               |

      # Color Palette
      |                                                                           |                                                                                              |
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
