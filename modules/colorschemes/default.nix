{ config, nix-colors, ... }:

{
  # colorscheme = nix-colors.colorSchemes.rose-pine-dawn;
  imports = [
    ./melange.nix
    # ./spicy.nix
  ];
}

