self: super: {
  purple-slack = super.purple-slack.overrideAttrs(old: {
    version = "2022-08-30";

    src = super.fetchFromGitHub {
      owner = "dylex";
      repo = "slack-libpurple";
      rev = "f91a5db6f148668afac8384eb349c545308b14fd";
      sha256 = "sha256-VrkjeE8MYyrjdhmFS4f1OZDN6v69lDKITQQUCj3/1zY=";
    };

    # Further ideas to add:
    # Adjust color of text rendered to start call or open chat
    # Add command to react to messages
    # Support sending of files
    # Prevent duplicates of incoming messages (happens from time to time)
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
