{ pkgs }:

pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "rose-pine.nvim";
  version = "v1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "neovim";
    rev = "v1.0.0";
    sha256 = "m6l5yjQiX5kclw34xzGwbLmh10oL+4F0kKB/b+TOMQ4=";
  };
  meta.homepage = "https://github.com/rose-pine/neovim/";
}
