{ fetchFromGitHub, stdenv, lib
, cmake, libGLU, libGL
, freetype, freeimage, zziplib, xorgproto, libXrandr
, libXaw, freeglut, libXt, libpng, boost, ois
, libX11, libXmu, libSM, pkgconfig
, libXxf86vm, libICE
, unzip
, libXrender
, withNvidiaCg ? false, nvidia_cg_toolkit
, withSamples ? false
, writeScriptBin
, rsync
, libobjc
, Foundation
, AppKit
, Cocoa }:

let ditto = writeScriptBin "ditto" ''
              #!${stdenv.shell}
              ${rsync}/bin/rsync "$@"
            '';
in

stdenv.mkDerivation rec {
  pname = "ogre";
  version = "1.12.9";

  src = fetchFromGitHub {
    owner = "OGRECave";
    repo = "ogre";
    rev = "v${version}";
    sha256 = "0b0pwh31nykrfhka6jqwclfx1pxzhj11vkl91951d63kwr5bbzms";
  };

  cmakeFlags = [ "-DOGRE_BUILD_SAMPLES=${toString withSamples}" ]
               ++ map (x: "-DOGRE_BUILD_PLUGIN_${x}=on")
                 ([ "BSP" "OCTREE" "PCZ" "PFX" ] ++ lib.optional withNvidiaCg "CG")
               ++ map (x: "-DOGRE_BUILD_RENDERSYSTEM_${x}=on") [ "GL" ]
               ++ lib.optionals stdenv.isDarwin [ "-DOGRE_ENABLE_PRECOMPILED_HEADERS=false" ];

  enableParallelBuilding = true;

  buildInputs =
    [ cmake libGLU libGL
      freetype freeimage zziplib xorgproto libXrandr
      libXaw freeglut libXt libpng boost ois
      libX11 libXmu libSM pkgconfig
      libXxf86vm libICE
      libXrender
    ] ++ lib.optional withNvidiaCg nvidia_cg_toolkit
    ++ lib.optionals stdenv.isDarwin [
      libobjc
      Foundation
      AppKit
      Cocoa
      ditto
    ];

  nativeBuildInputs = [ unzip ];

  meta = {
    description = "A 3D engine";
    homepage = "https://www.ogre3d.org/";
    maintainers = [ stdenv.lib.maintainers.raskin ];
    platforms = stdenv.lib.platforms.unix;
    license = stdenv.lib.licenses.mit;
  };
}
