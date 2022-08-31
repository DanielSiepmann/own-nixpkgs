self: super: {
  purple-slack = super.purple-slack.overrideAttrs(old: {
    version = "2022-08-30";

    src = super.fetchFromGitHub {
      owner = "dylex";
      repo = "slack-libpurple";
      rev = "90da1de76425b5d4485c578597be14dbd5b539c8";
      sha256 = "sha256-WqAQIDN947Wzns8QIZn7MUNmy2s35g0axIC1fjg1YCU=";
    };

    patches = (old.patches or []) ++ [
      ./browser-based-auth.patch
      ./call-transformation.patch
      ./call-command.patch
    ];
  });
}
