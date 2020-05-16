let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  niv = import sources.niv { inherit pkgs; };

in
  with pkgs;
  mkShell {
    inherit ((import ./default.nix).pre-commit-check) shellHook;
    buildInputs = [
      niv.niv
      nixpkgs-fmt
      git
    ];
  }
