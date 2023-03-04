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

  shell = "${pkgs.zsh}/bin/zsh";

  sensibleOnTop = false;

  plugins = with pkgs.tmuxPlugins; [
    {
      plugin = fzf-tmux-url;
      extraConfig = ''
        set -g @fzf-url-fzf-options '-p -y 1 -w 95% -h 75%'
      '';
    }
  ];

  extraConfig = builtins.readFile ../files/tmux;
}
