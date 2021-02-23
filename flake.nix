{
  description = "Python packages as flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    parsemon2.url = "github:seppeljordan/parsemon2";
  };

  outputs = { self, nixpkgs, flake-utils, parsemon2 }:
    let
      packageOverrides = let
        parsemonOverrides = parsemon2.lib.packageOverrides;
        selfOverrides = import ./package-overrides.nix;
      in nixpkgs.lib.composeExtensions parsemonOverrides selfOverrides;
      overlay = let
        flakeOverlay = final: prev: {
          python3 = prev.python3.override { inherit packageOverrides; };
        };
      in final: prev:
      (nixpkgs.lib.composeExtensions parsemon2.overlay flakeOverlay) final prev;
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
              injector pytest-profiling parsemon2 auditwheel;
          };
        });
    in { inherit overlay packageOverrides; } // systemDependent;
}
