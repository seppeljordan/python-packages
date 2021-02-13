self: super:
let callPackage = self.callPackage;
in {
  bumpv = callPackage ./bumpv.nix { };
  injector = callPackage ./injector.nix { };
  pytest-profiling = callPackage ./pytest-profiling.nix { };
}
