{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  lib,
  pidgin,
  libnotify
}:

stdenv.mkDerivation rec {
  pname = "purple-events";
  version = "v0.99.2";
  src = fetchFromGitHub {
    owner = "sardemff7";
    repo = "purple-events";
    rev = version;
    sha256 = "sha256-np1Wo9xqRclBY24Ww2WnQ1lxKEsRsM16BxinkfyPgKc=";
  };

  postPatch = ''
      substituteInPlace meson.build \
        --replace "purple.get_variable('datadir')" "'${placeholder "out"}/share'"
      substituteInPlace meson.build \
        --replace "purple.get_variable('plugindir')" "'${placeholder "out"}/lib/purple-2'"
  '';

  buildInputs = [
    meson
    pidgin
    libnotify
    ninja
  ];

  meta = with lib; {
    homepage = "https://github.com/sardemff7/purple-events";
    description = "purple-events allows a fine-grained control over libpurple events (buddy signing on, new message).";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
