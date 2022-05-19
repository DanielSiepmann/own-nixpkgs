{ config, pkgs }:

{
  enable = true;

  autocd = true;
  enableSyntaxHighlighting = true;

  defaultKeymap = "viins";

  # Can be re sourced via: __HM_ZSH_SESS_VARS_SOURCED= source ~/.zshenv
  sessionVariables = {
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    LANGUAGE = "en_US";

    MANPAGER="${pkgs.page}/bin/page -C -e 'au User PageDisconnect sleep 100m|%y p|enew! |bd! #|pu p|set ft=man'";
    EDITOR = "${pkgs.neovim}/bin/nvim";
    SHELL = "${pkgs.zsh}/bin/zsh";

    LSCOLORS = "HxGxDxDxbxDxDxababcxcx";
    LS_COLORS = "di=1;37:ln=1;36:so=1;33:pi=1;33:ex=31:bd=1;33:cd=1;33:su=30;41:sg=30;41:tw=32:ow=32";
    GREP_COLOR = "0;30;44";

    TYPO3_CONTEXT = "Development/dsiepmann";
    TYPO3_ADDITIONAL_CONFIGURATION = "/home/daniels/.local/share/typo3-configuration/AdditionalConfiguration.inc.php";
    PHAN_COLOR_SCHEME = "code";

    # Reduce timeout after <ESC> (vi keybindings)
    KEYTIMEOUT = 1;
  };

  shellAliases = {
    ll = "ls -laph --color=auto";

    # Open in main view with all references.
    tigr = "tig refs";
    # Open in main view with ALL commits, not only current branch tree.
    tiga = "tig --all --show-signature";

    # Tmux outside tmux.
    ta = "tmux attach";
    tc = "tmux new-session -s ";

    # TYPO3 contribution specific commands
    t3Push = "git push origin HEAD:refs/for/master";
    t3Pull = "git pull --rebase origin master; git checkout master";
    t3Rollback = "git checkout master; git reset --hard origin/master";
    t3Clean = "t3Rollback && t3Pull";

    # Create borg backup
    createBackup = "mkdir -p ~/backup-etc && sudo cp -r /etc/* ~/backup-etc && sudo cp -r /etc/.* ~/backup-etc && sudo chown daniels:daniels -R ~/backup-etc/ && borg create -v --progress --stats --exclude-from ~/.config/borg/exclude /media/daniels/Backup::$(date +%F-%R) ~/; sudo rm -rf ~/backup-etc";
  };

  history = {
    size = 10000;
    save = 10000;
    ignoreDups = true;
    ignoreSpace = true;
    extended = true;
    share = false;
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
