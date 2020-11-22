{ stdenv, lib, python3, fetchFromGitHub }:

python3.pkgs.buildPythonApplication rec {
  pname = "angr";
  version = "9.0.4495";

  src = fetchFromGitHub {
    owner = "angr";
    repo = "angr";
    rev = "v${version}";
    sha256 = "0nsri6zczh7lk0v2k4wb71l3hap6i42jvnfx895d4znnn37s5bcd";
  };

  propagatedBuildInputs = with python3.pkgs; [
    progressbar2
  ];

  meta = with stdenv.lib; {
    description = " A powerful and user-friendly binary analysis platform";
    homepage = "https://github.com/angr/angr";
    license = licenses.bsd2;
    maintainers = with maintainers; [ siraben ];
    platforms = lib.platforms.unix;
  };
}
