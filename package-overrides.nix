self: super:
let callPackage = self.callPackage;
in {
  injector = callPackage ./injector.nix { };
  pytest-profiling = callPackage ./pytest-profiling.nix { };
}
