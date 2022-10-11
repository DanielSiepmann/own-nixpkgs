{ config, pkgs }:

{
  enable = true;

  dotDir = ".config/zsh";

  autocd = true;
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

  initExtra = ''
    autoload -U colors && colors
    autoload -U promptinit
    autoload -U complist

    # Set vim mode
    set -o vi

    # Allow editing of current line in $EDITOR using command mode V
    autoload -U edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd v edit-command-line

    # ctrl-r search history backward to keep old pattern
    bindkey '^r' history-incremental-search-backward
    # ctrl-j search history backward to have vim like binding
    # TODO: Find out why this breaks within neoterminal when sending commands like from test or repl
    # bindkey '^j' history-incremental-search-backward
    # # ctrl-k search history forward to have vim like binding
    bindkey '^k' history-search-forward


    zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
    zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
    zstyle ':completion:*' menu select
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    zstyle ':completion:*' cache-path ${config.xdg.cacheHome}/zsh-completion/

    zstyle ':completion:*' group-name '''
    zstyle ':completion::complete:git-checkout:argument-rest:' group-order heads-local heads-remote commit-tags
    zstyle ':completion::complete:git-checkout:argument-rest:commits' command 'echo'
    zstyle ':completion::complete:git-checkout:argument-rest:valid-ref-names' command 'echo'
    zstyle ':completion::complete:git-checkout:argument-rest:remote-branch-refs-noprefix' command 'echo'

    # also complete defined alias
    setopt completealiases
    # Correct mistyped commands
    setopt correctall
    # Try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths.
    setopt list_packed
    # When listing files that are possible completions, show the type of each file with a trailing identifying mark.
    setopt list_types

    # Allow for functions in the prompt.
    setopt PROMPT_SUBST

    PROMPT=$'%{$fg[blue]%}%1~ > %{$reset_color%}'
  '';
}
