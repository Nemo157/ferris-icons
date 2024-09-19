{ lib, runCommand, fantasticon, just, stdenvNoCC }: stdenvNoCC.mkDerivation {
  pname = "ferris-icons";
  version = "owo";

  src = ./.;

  nativeBuildInputs = [ fantasticon just ];

  buildPhase = ''
    just build
  '';

  installPhase = ''
    install -Dm644 -t $out/share/fonts/truetype dist/ferris-icons.ttf
  '';
}
