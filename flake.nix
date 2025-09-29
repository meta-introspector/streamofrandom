{
  description = "A basic flake for streamofrandom";

  inputs = {
    nixpkgs.url = "github:meta-introspector/nixpkgs?ref=feature/CRQ-016-nixify";
    flake-utils.url = "github:meta-introspector/flake-utils?ref=feature/CRQ-016-nixify";
    vendoredLintStaged.url = "github:meta-introspector/time-2025?ref=feature/CRQ-016-nixify&dir=/09/27/7-concepts/1-build-system";
  };

  outputs = { self, nixpkgs, flake-utils, vendoredLintStaged }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.git
            pkgs.nix
            pkgs.bash
            pkgs.coreutils
            pkgs.pre-commit
            pkgs.nixpkgs-fmt
            pkgs.statix
            pkgs.shellcheck
            pkgs.nodePackages."@commitlint/cli"
            pkgs.vale
            pkgs.nodejs
            vendoredLintStaged.packages.${system}.vendoredLintStaged
          ];
        };
      }
    );
}