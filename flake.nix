{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {

    overlays.default = final: prev: {
      ferris-icons = final.callPackage ./package.nix {
        fantasticon = final.buildNpmPackage rec {
          pname = "fantasticon";
          version = "3.0.0";

          src = final.fetchFromGitHub {
            owner = "tancredi";
            repo = pname;
            rev = "v${version}";
            hash = "sha256-PKkeRow+Shdd/7EBhbABthjwKzt183darOD8gv6Mczs=";
          };

          patches = [
            # fix handling of emoji codepoints
            (final.fetchpatch {
              url = "https://patch-diff.githubusercontent.com/raw/tancredi/fantasticon/pull/507.patch";
              hash = "sha256-Bli14e/6bR/t4yS0R0Xqp4SU2ULUN1Y+hfB1Qh6NV6k=";
            })
          ];

          npmDepsHash = "sha256-uW6JSWJrwWPGbh66fGmXyqI2MObpzB4uGQopmhi+ZrI=";
        };
      };
    };

  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };
    in {
      packages = rec {
        inherit (pkgs) ferris-icons;
        default = ferris-icons;
      };

      checks = {
        inherit (pkgs) ferris-icons;
      };

      devShells.default = pkgs.mkShell {
        inputsFrom = with pkgs; [ ferris-icons ];
        nativeBuildInputs = with pkgs; [ watchexec ];
      };
    }
  );
}
