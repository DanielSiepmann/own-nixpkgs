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
  # Use screen instead of tmux as some tools might not be aware of tmux
  terminal = "screen-256color";

  shell = "zsh";

  sensibleOnTop = false;

  extraConfig = builtins.readFile ../files/tmux;
}
