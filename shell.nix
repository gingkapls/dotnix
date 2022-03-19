{
  stdenvNoCC,
  writeShellScript,
}: let
  pre-commit = writeShellScript "pre-commit" ''
    nix eval --raw .#nixosConfigurations.amethyst.config.home-manager.users.gin.home.file."README-md".text > README.md
    git add README.md
  '';
in
  stdenvNoCC.mkDerivation {
    name = "development-shell";
    shellHook = ''
      echo "Installing pre-commit hook..."
      ln -sf ${pre-commit} .git/hooks/pre-commit
    '';
  }
