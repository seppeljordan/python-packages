{ buildPythonPackage, fetchFromGitHub, typing-extensions, pytest, pytestcov
, pytestCheckHook }:
buildPythonPackage rec {
  pname = "injector";
  version = "0.18.4";
  src = with builtins;
    fetchFromGitHub (fromJSON (readFile injector/alecthomas.json));
  buildInputs = [ pytestCheckHook ];
  propagatedBuildInputs = [ typing-extensions ];
  checkInputs = [ pytest pytestcov ];
}
