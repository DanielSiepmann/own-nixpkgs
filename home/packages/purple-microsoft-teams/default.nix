{
  stdenv,
  fetchFromGitHub,
  lib,
  pidgin,
  glib,
  json-glib
}:

stdenv.mkDerivation rec {
  pname = "purple-teams";
  version = "7c7bc282f9aee3402130d7d88d53b89549167f22";
  src = fetchFromGitHub {
    owner = "EionRobb";
    repo = pname;
    rev = version;
    sha256 = "sha256-yflGQtebZE44oN/GiC/YOD2JTa997atj5wseBEjEsMA=";
  };

  PKG_CONFIG_PURPLE_PLUGINDIR = "${placeholder "out"}/lib/purple-2";
  PKG_CONFIG_PURPLE_DATAROOTDIR = "${placeholder "out"}/share";

  nativeBuildInputs = [
    pidgin
    glib
    json-glib
  ];

  meta = with lib; {
    homepage = "https://github.com/EionRobb/purple-teams";
    description = "Plugin for Pidgin which adds support for Microsoft Teams";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
