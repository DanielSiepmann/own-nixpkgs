{
  lib,
  fetchFromGitHub,
  bundlerApp,
  bundlerUpdateScript,
  makeWrapper,
  ruby
}:

bundlerApp rec {
  pname = "sitediff";
  exes = [ "sitediff" ];

  inherit ruby;
  gemdir = ./.;

  buildInputs = [ makeWrapper ];

  passthru.updateScript = bundlerUpdateScript "sitediff";

  meta = with lib; {
    description = "SiteDiff makes it easy to see differences between two versions of a website.";
    homepage = "https://sitediff.io/";
    changelog = "https://github.com/evolvingweb/sitediff/commits/master";
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
  };
}

