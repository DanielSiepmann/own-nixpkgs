{
  lib,
  bundlerApp,
  makeWrapper,
  ruby_3_1
}:

# See: https://nixos.wiki/wiki/Packaging/Ruby
# I've placed a shell.nix so nix-shell within the folder and project-update should update.

bundlerApp rec {
  pname = "sitediff";
  exes = [ "sitediff" ];

  ruby = ruby_3_1;
  gemdir = ./.;

  buildInputs = [ makeWrapper ];

  passthru.updateScript = ./update.sh;

  meta = with lib; {
    description = "SiteDiff makes it easy to see differences between two versions of a website.";
    homepage = "https://sitediff.io/";
    changelog = "https://github.com/evolvingweb/sitediff/commits/master";
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
  };
}
