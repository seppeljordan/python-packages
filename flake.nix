{
  description = "nix-prefetch-github";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    parsemon2.url = "github:seppeljordan/parsemon2";
  };

  outputs = { self, nixpkgs, flake-utils, parsemon2 }:
    let
      packageOverrides = let
        parsemonOverrides = self: super: {
          parsemon2 = self.callPackage parsemon2.lib.package { };
        };
        selfOverrides = import ./package-overrides.nix;
      in nixpkgs.lib.composeExtensions parsemonOverrides selfOverrides;
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
          devShell =
            pkgs.mkShell { buildInputs = with pkgs; [ nixfmt python3 ]; };
          packages = { inherit (pkgs) python3; };
          checks = {
            inherit (pkgs.python3.pkgs)
              injector pytest-profiling parsemon2;
          };
        });
    in { inherit overlay packageOverrides; } // systemDependent;
}
