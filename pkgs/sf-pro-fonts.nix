{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "sf-fonts";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sahibjotsaggu";
    repo = "San-Francisco-Pro-Fonts";
    rev = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
    hash = "sha256-mAXExj8n8gFHq19HfGy4UOJYKVGPYgarGd/04kUIqX4=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype
    cp *.otf $out/share/fonts/opentype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://rsms.me/inter/";
    description = "A typeface specially designed for user interfaces";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ demize dtzWill ];
  };
}

