{ stdenv, lib, fetchFromGitHub, autoreconfHook, gaucheBootstrap, pkg-config, texinfo
,  libiconv, gdbm, openssl, zlib, mbedtls, cacert }:

stdenv.mkDerivation rec {
  pname = "gauche";
  version = "0.9.10";

  src = fetchFromGitHub {
    owner = "shirok";
    repo = pname;
    rev = "release${lib.replaceChars [ "." ] [ "_" ] version}";
    sha256 = "1lnfhywj3p3708qxsjqr6qp0dw68fx5lvj1djbsrd213w59p1v51";
  };

  nativeBuildInputs = [ gaucheBootstrap pkg-config texinfo autoreconfHook ];

  buildInputs = [ libiconv gdbm openssl zlib mbedtls cacert ];

  autoreconfPhase = ''
    ./DIST gen
  '';

  postPatch = ''
    patchShebangs .
  '';

  configureFlags = [
    "--with-iconv=${libiconv}"
    "--with-dbm=gdbm"
    "--with-zlib=${zlib}"
    "--with-ca-bundle=${cacert}/etc/ssl/certs/ca-bundle.crt"
    # TODO: Enable slib
    #       Current slib in nixpkgs is specialized to Guile
    # "--with-slib=${slibGuile}/lib/slib"
  ];

  enableParallelBuilding = true;

  # TODO: Fix tests that fail in sandbox build
  doCheck = false;

  meta = with lib; {
    description = "R7RS Scheme scripting engine";
    homepage = "https://practical-scheme.net/gauche/";
    maintainers = with maintainers; [ mnacamura ];
    license = licenses.bsd3;
    platforms = platforms.unix;
  };
}
