self: super: {
  mytop = super.pkgs.perlPackages.buildPerlPackage rec {
    pname = "mytop";
    version = "1.6";

    src = super.pkgs.fetchurl {
      url = "https://jeremy.zawodny.com/mysql/${pname}/${pname}-${version}.tar.gz";
      sha256 = "b17c702598b10bb0ce2695f609122637c799eaaaec1afaa73246b048f07be9bd";
    };

    # TODO: Builds, but is not executable
    # I've no clue of perl, never used it.
    # Error when executing:
    # Can't locate DBI.pm in @INC (you may need to install the DBI module)
    # Didn't find anything relating dbi for perl in nixpks.
    # It self explaines: runs on most Unix systems which have Perl, DBI, and Term::ReadKey installed. And with Term::ANSIColor installed you even get color.

    outputs = [
      "out"
    ];

    meta = with super.lib; {
      description = "A top clone for MySQL";
      homepage = "https://jeremy.zawodny.com/mysql/mytop/";
      license = licenses.gpl2Only;
    };
  };
}
