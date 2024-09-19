{ lib, runCommand, fantasticon, stdenvNoCC }: stdenvNoCC.mkDerivation {
  pname = "ferris-icons";
  version = "owo";

  src = ./.;

  nativeBuildInputs = [ fantasticon ];

  buildPhase = ''
    fantasticon
  '';

  installPhase = ''
    install -Dm644 -t $out/share/fonts/truetype dist/ferris-icons.ttf
  '';
}
