self: super: {
  purple-slack = super.purple-slack.overrideAttrs(old: {
    version = "2022-08-30";

    src = super.fetchFromGitHub {
      owner = "dylex";
      repo = "slack-libpurple";
      rev = "90da1de76425b5d4485c578597be14dbd5b539c8";
      sha256 = "sha256-WqAQIDN947Wzns8QIZn7MUNmy2s35g0axIC1fjg1YCU=";
    };

    # Further ideas to add:
    # Add command to react to messages
    # Prevent duplicates of incoming messages (happens from time to time)
    # Formatting (bold, italic, …) see: https://github.com/dylex/slack-libpurple/pull/122
    # Transform emoticons
    # Receive reactions
    patches = (old.patches or []) ++ [
      ./browser-based-auth.patch
      ./call-transformation.patch
      ./call-command.patch
      ./open-command.patch
    ];
  });
}
