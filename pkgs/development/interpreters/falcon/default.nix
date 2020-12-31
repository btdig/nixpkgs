{ stdenv, fetchFromGitHub, cmake, pkg-config, pcre, zlib, sqlite }:

stdenv.mkDerivation {
  pname = "falcon";
  version = "unstable-2018-10-23";

  src = fetchFromGitHub {
    owner = "falconpl";
    repo = "falcon";
    rev = "637e2d5cd950a874496042993c02ab7d17c1b688";
    sha256 = "iCyvvZJjXb1CR396EJ6GiP6d4e7iAc6QQlAOQoAfehg=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ pcre zlib sqlite ];

  meta = with stdenv.lib; {
    description = "Programming language with macros and syntax at once";
    license = licenses.gpl2;
    maintainers = with maintainers; [ pSub ];
    platforms = with platforms; linux;
  };
}
