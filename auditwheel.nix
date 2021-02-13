{ buildPythonPackage, fetchPypi, pbr, pyelftools }:
buildPythonPackage rec {
  pname = "auditwheel";
  version = "3.3.1";
  src = fetchPypi {
    inherit pname version;
    sha256 = "xX0bxjOIGxZEWHQnbopL7PU1sXCjDdHQpWe41j1j2zU=";
  };
  buildInputs = [ pbr pyelftools ];
  doCheck = false;
}
