self: super: {
  luabind-ryzom = self.stdenv.mkDerivation {
    pname = "luabind-ryzom";
    version = "bbb9f4023100516727a427bd882c4db4ede7af69";

    src = self.fetchFromGitHub {
      owner = "ryzom";
      repo = "luabind";
      rev = "bbb9f4023100516727a427bd882c4db4ede7af69";
      sha256 = "";
    };

    nativeBuildInputs = with self; [
      lua
    ];

    meta = with self.lib; {
      homepage = "https://ryzom.com/";
      description = "A library that helps you create bindings between C++ and Lua";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };

  libsquish = self.stdenv.mkDerivation {
    pname = "libsquish";
    version = "1.15";

    src = self.fetchurl {
      url = "http://downloads.sourceforge.net/project/libsquish/libsquish-1.15.tgz";
      sha256 = "YoeW7rpgiGYYOmHQgNRpZ8ndpnI7wKPsUjJMhdIUcmk=";
    };

    meta = with self.lib; {
      homepage = "https://sourceforge.net/projects/libsquish/";
      description = "DXT compression library";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };

  ryzom = self.stdenv.mkDerivation {
    pname = "ryzom";
    version = "6b0899a051f2c74ff5ec380688753474a5021df9";

    src = self.fetchFromGitHub {
      owner = "ryzom";
      repo = "ryzomcore";
      rev = "6b0899a051f2c74ff5ec380688753474a5021df9";
      sha256 = "";
    };

    nativeBuildInputs = with self; [
      # cpptest
      # cmake

      # freetype2
      curl
      xorg.libX11
      xorg.libXxf86vm
      mesa
      openal
      freealut
      libogg
      libvorbis
      libxml2
      libpng
      libjpeg
      boost
      luabind-ryzom
      libsquish
      lua
      mariadb
      giflib
      ffmpeg
      libgsf
      qt5.qtbase
      qt5.qttools
    ];

    postPatch = ''
      mv $src/ryzom/client/* /tmp/
      rm -rf $src/*
      mv /tmp/* $src/
    '';

    meta = with self.lib; {
      homepage = "https://ryzom.com/";
      description = "Ryzom is a Free to Play MMORPG . This version is for playing on an official server or launch a server";
      license = licenses.agpl3;
      platforms = platforms.linux;
    };
  };
}
