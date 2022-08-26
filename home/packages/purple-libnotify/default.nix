{
  stdenv,
  fetchFromGitHub,
  callPackage,
  meson,
  ninja,
  lib,
  pidgin,
  libnotify
}:

stdenv.mkDerivation rec {
  pname = "purple-libnotify+";
  version = "v2.99.2";
  src = fetchFromGitHub {
    owner = "sardemff7";
    repo = "purple-libnotify-plus";
    rev = version;
    sha256 = "sha256-967VKfRjy5eQiFda5mqW3eLqvuPqWEDoIsixhZNNmsU=";
  };

  postPatch = ''
      substituteInPlace meson.build \
        --replace "purple.get_variable('datadir')" "'${placeholder "out"}/share'"
      substituteInPlace meson.build \
        --replace "purple.get_variable('plugindir')" "'${placeholder "out"}/lib/purple-2'"
  '';

  buildInputs = [
    meson
    ninja
    pidgin
    libnotify
    (callPackage ./../purple-events {})
  ];

  meta = with lib; {
    homepage = "https://github.com/sardemff7/purple-libnotify-plus/";
    description = "Plugin for Pidgin which adds support for notifications via libnotify";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
