{ buildPythonPackage, fetchFromGitHub, typing-extensions, pytest, pytestcov }:
buildPythonPackage rec {
  pname = "injector";
  version = "0.18.4";
  src = with builtins;
    fetchFromGitHub (fromJSON (readFile injector/alecthomas.json));
  propagatedBuildInputs = [ typing-extensions ];
  checkInputs = [ pytest pytestcov ];
  checkPhase = ''
    python -m pytest injector_test.py
  '';
}
