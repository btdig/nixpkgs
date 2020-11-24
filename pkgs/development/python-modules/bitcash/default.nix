{ stdenv, lib, python3Packages, python3 }:

python3Packages.buildPythonPackage rec {
  pname = "bitcash";
  version = "0.6.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "09i6fvjc2mrz4s956pcjrrb5xab8wf542pirybzf6wbh4n57kisq";
  };

  propagatedBuildInputs = with python3.pkgs; [
    coincurve requests
  ];

  meta = with stdenv.lib; {
    description = "Python 3 Bitcoin Cash Library";
    homepage = "https://github.com/pybitcash/bitcash";
    license = licenses.mit;
    maintainers = with maintainers; [ siraben ];
    platforms = lib.platforms.unix;
  };
}
