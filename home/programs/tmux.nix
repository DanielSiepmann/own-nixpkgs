{ pkgs }:

{
  enable = true;

  # Accordingly to neovim  https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
  escapeTime = 10;
  keyMode = "vi";
  shortcut = "t";
  customPaneNavigationAndResize = true;

  resizeAmount = 5;
  aggressiveResize = true;

  # Use tmux with 256 colors.
  # Also see https://github.com/neovim/neovim/wiki/FAQ#colors-arent-displayed-correctly
  terminal = "tmux-256color";

  shell = "${pkgs.zsh}/bin/zsh";

  sensibleOnTop = false;

  extraConfig = builtins.readFile ../files/tmux;
}
