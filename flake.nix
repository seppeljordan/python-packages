{
  description = "nix-prefetch-github";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      packageOverrides = import ./package-overrides.nix;
      overlay = final: prev: {
        python3 = prev.python3.override { inherit packageOverrides; };
      };
      systemDependent = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs {
            overlays = [ overlay ];
            system = system;
          };
        in {
          packages = { inherit (pkgs) python3; };
          checks = { inherit (pkgs.python3.pkgs) injector; };
        });
    in { inherit overlay packageOverrides; } // systemDependent;
}
