{ stdenv, lib, fetchFromGitHub, coq, mathcomp }:

stdenv.mkDerivation rec {
  pname = "fourcolor";
  name = "coq${coq.coq-version}-fourcolor-${version}";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "math-comp";
    repo = "fourcolor";
    rev = "v${version}";
    sha256 = "1lw9kfmz1ycdgrpbhz6r7dgc8vq7x2zamd9wmgycvsqklmp4k8rv";
  };

  buildInputs = [ coq ] ++ (with coq.ocamlPackages; [ ocaml ocamlbuild ]);

  propagatedBuildInputs = [ mathcomp ];

  installFlags = [ "COQLIB=$(out)/lib/coq/${coq.coq-version}/" ];

  passthru = {
    compatibleCoqVersions = v: builtins.elem v [ "8.7" "8.8" "8.9" "8.10" "8.11" "8.12" ];
  };
  meta = with stdenv.lib; {
    description = "Formal proof of the Four Color Theorem";
    homepage = "https://github.com/math-comp/fourcolor";
    # CeCILL-B FREE SOFTWARE LICENSE AGREEMENT
    license = licenses.free;
    maintainers = with maintainers; [ siraben ];
    platforms = coq.meta.platforms;
  };
}
