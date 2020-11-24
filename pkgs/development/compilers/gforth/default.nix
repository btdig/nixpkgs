{ stdenv,  lib, fetchurl, m4, buildPackages, gforth }:

let
  version = "0.7.3";
in
stdenv.mkDerivation {
  pname = "gforth";
  inherit version;
  src = fetchurl {
    url = "https://ftp.gnu.org/gnu/gforth/gforth-${version}.tar.gz";
    sha256 = "1c1bahc9ypmca8rv2dijiqbangm1d9av286904yw48ph7ciz4qig";
  };

  configurePlatforms = [ "build" "host" ] ++ stdenv.lib.optional (stdenv.targetPlatform != stdenv.hostPlatform) "target";
  nativeBuildInputs = [ m4 ] ++ lib.optional (stdenv.hostPlatform != stdenv.buildPlatform) gforth;

  postInstall = ''
    mkdir -p $out/share/emacs/site-lisp
    cp gforth.el $out/share/emacs/site-lisp/
  '';

  meta = {
    description = "The Forth implementation of the GNU project";
    homepage = "https://www.gnu.org/software/gforth/";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.all;
  };
}
