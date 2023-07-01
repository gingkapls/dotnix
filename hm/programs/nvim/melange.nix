{ pkgs }:

pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "melange.nvim";
  version = "v1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "savq";
    repo = "melange";
    rev = "v0.8.0";
    sha256 = "sha256-oVN7A1fYNd40+3uKmTYzLWtr5072XbRv/HiFzAbMCuw=";
  };
  meta.homepage = "https://github.com/savq/melange";
}
