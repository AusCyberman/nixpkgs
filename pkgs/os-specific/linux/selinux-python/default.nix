{ lib, stdenv, fetchurl, python3
, libselinux, libsemanage, libsepol, setools }:

# this is python3 only because setools only supports python3

with lib;

stdenv.mkDerivation rec {
  pname = "selinux-python";
  version = "2.9";

  inherit (libsepol) se_release se_url;

  src = fetchurl {
    url = "${se_url}/${se_release}/selinux-python-${version}.tar.gz";
    sha256 = "1pjzsyay5535cxcjag7y7k193ajry0s0xc3dqv5905qd7cwval1n";
  };

  strictDeps = true;

  nativeBuildInputs = [ python3 python3.pkgs.wrapPython ];
  buildInputs = [ libsepol ];
  propagatedBuildInputs = [ libselinux libsemanage setools python3.pkgs.ipy ];

  postPatch = ''
    substituteInPlace sepolicy/Makefile --replace "echo --root" "echo --prefix"
    substituteInPlace sepolgen/src/share/Makefile --replace "/var/lib/sepolgen" \
                                                            "\$PREFIX/var/lib/sepolgen"
  '';

  makeFlags = [
    "PREFIX=$(out)"
    "LOCALEDIR=$(out)/share/locale"
    "BASHCOMPLETIONDIR=$(out)/share/bash-completion/completions"
    "PYTHON=python"
    "PYTHONLIBDIR=$(out)/${python3.sitePackages}"
    "LIBSEPOLA=${lib.getLib libsepol}/lib/libsepol.a"
  ];


  postFixup = ''
    wrapPythonPrograms
  '';

  meta = {
    description = "SELinux policy core utilities written in Python";
    license = licenses.gpl2;
    homepage = "https://selinuxproject.org";
    platforms = platforms.linux;
  };
}

