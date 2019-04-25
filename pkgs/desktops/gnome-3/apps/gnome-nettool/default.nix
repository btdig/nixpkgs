{ stdenv, fetchurl, pkgconfig, gnome3, gtk3, wrapGAppsHook
, libgtop, intltool, itstool, libxml2, nmap, inetutils }:

stdenv.mkDerivation rec {
  pname = "gnome-nettool";
  version = "3.8.1";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "1c9cvzvyqgfwa5zzyvp7118pkclji62fkbb33g4y9sp5kw6m397h";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    gtk3 wrapGAppsHook libgtop intltool itstool libxml2
    gnome3.adwaita-icon-theme
  ];

  propagatedUserEnvPkgs = [ nmap inetutils ];

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
      attrPath = "gnom3.gnome-nettool";
      versionPolicy = "none";
    };
  };

  meta = with stdenv.lib; {
    homepage = http://projects.gnome.org/gnome-network;
    description = "A collection of networking tools";
    maintainers = gnome3.maintainers;
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
