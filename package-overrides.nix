self: super:
let callPackage = super.callPackage;
in {
  bumpv = self.callPackage ./bumpv.nix { };
  injector = callPackage ./injector.nix { };
  pytest-profiling = self.callPackage ./pytest-profiling.nix { };
}
