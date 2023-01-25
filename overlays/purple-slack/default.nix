self: super: {
  purple-slack = super.purple-slack.overrideAttrs(old: {
    version = "2023-01-19";

    src = super.fetchFromGitHub {
      owner = "dylex";
      repo = "slack-libpurple";
      rev = "6778b7c7ae28d9b62339262245c8ca7d11fb5a16";
      sha256 = "sha256-smv2/bHLD5OJyUZhvgzqqzYO6NVWAY6d0dLamiXIEm4=";
    };

    # Further ideas to add:
    # Adjust color of text rendered to start call or open chat
    # Add command to react to messages
    #   https://github.com/dylex/slack-libpurple/issues/155
    # Support sending of files
    # Prevent duplicates of incoming messages (happens from time to time)
    #   https://github.com/dylex/slack-libpurple/issues/155
    # Formatting (bold, italic, …) see: https://github.com/dylex/slack-libpurple/pull/122
    # Receive reactions
    patches = (old.patches or []) ++ [
      # 3rd Party
      ./browser-based-auth.patch

      # Own
      ./open-command.patch

      # Send upstream
      ./call-command.patch
    ];
  });
}
