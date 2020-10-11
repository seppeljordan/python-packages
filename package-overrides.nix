self: super:
let callPackage = super.callPackage;
in { injector = callPackage ./injector.nix { }; }
