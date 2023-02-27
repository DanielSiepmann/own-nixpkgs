{ config, pkgs }:

# Sources:
# https://thevaluable.dev/zsh-install-configure-mouseless/
# https://thevaluable.dev/zsh-completion-guide-examples/

{
  enable = true;

  dotDir = ".config/zsh";

  autocd = false;
  enableSyntaxHighlighting = true;

  defaultKeymap = "viins";

  # Can be re sourced via: __HM_ZSH_SESS_VARS_SOURCED= source ~/.zshenv
  sessionVariables = {
    # Reduce timeout after <ESC> (vi keybindings)
    KEYTIMEOUT = 1;
  };

  history = {
    size = 10000;
    save = 10000;
    ignoreDups = true;
    ignoreSpace = true;
    extended = true;
    share = false;
    path = "${config.xdg.dataHome}/zsh/zsh_history";
  };

  initExtra = builtins.readFile(../files/zshrc) + ''
    zstyle ':completion:*' cache-path ${config.xdg.cacheHome}/zsh-completion/
  '';
}
