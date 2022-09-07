{
  lib,
  fetchFromGitHub,
  bundlerApp,
  bundlerUpdateScript,
  makeWrapper,
  ruby_3_1
}:

# 1. cd into this folder
# 2. start nix shell: nix-shell -p ruby_3_1 -p bundix
# 3. clean tings up: rm Gemfile.lock gemset.nix
# 4. Generate files again: bundle lock; bundix -l
# 5. Manually keep old sha256 hash of nokogiri dependency

# Issue seems to be platform specific "nokogiri (1.13.8-x86_64-linux)" which is not yet supported by gemset, leading to different versions and hashes

bundlerApp rec {
  pname = "sitediff";
  exes = [ "sitediff" ];

  ruby = ruby_3_1;
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

