let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};

in
  with pkgs;
  mkShell {
    inherit ((import ./default.nix).pre-commit-check) shellHook;
    buildInputs = [
      pkgs.niv
      nixpkgs-fmt
    ];
  }
