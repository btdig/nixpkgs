{ stdenv, lib, python3Packages, python3, automake, pkg-config, libtool, libffi, gmp }:

python3Packages.buildPythonPackage rec {
  pname = "coincurve";
  version = "13.0.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "1x8dpbq6bwswfyi1g4r421hnswp904l435rf7n6fj7y8q1yn51cr";
  };

  enableParallelBuilding = true;

  propagatedBuildInputs = with python3.pkgs; [
    cffi
    asn1crypto
    secp256k1
  ];

  nativeBuildInputs = [ automake pkg-config ];
  buildInputs = [ libtool libffi gmp ];

  meta = with stdenv.lib; {
    description = "Cross-platform Python CFFI bindings for libsecp256k1";
    homepage = "https://github.com/ofek/coincurve";
    license = licenses.asl20;
    maintainers = with maintainers; [ siraben ];
    platforms = lib.platforms.unix;
  };
}
