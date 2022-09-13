{ pkgs }:

let
  enLocale = "en_US.utf8";
  deLocale = "de_DE.utf8";

in {

    language = {
      # English

      base = "${enLocale}";
      ctype = "${enLocale}";
      numeric = "${enLocale}";
      collate = "${enLocale}";
      messages = "${enLocale}";

      # German
      time = "${deLocale}";
      monetary = "${deLocale}";
      paper = "${deLocale}";
      name = "${deLocale}";
      address = "${deLocale}";
      telephone = "${deLocale}";
      measurement = "${deLocale}";
    };

    keyboard = {
      layout = "us";
      model = "pc105";
      options = [
        "numpad:mac"
        "ctrl:nocaps"
        "compose:ralt"
      ];
    };

    pointerCursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir-dark";
      size = 16;
      x11.enable = true;
      gtk.enable = true;
    };

    sessionVariables = {
      TERMINAL = "st";
      EDITOR = "nvim";
      SHELL = "zsh";

      TYPO3_CONTEXT = "Development/dsiepmann";
      TYPO3_ADDITIONAL_CONFIGURATION = "/home/daniels/.local/share/typo3-configuration/AdditionalConfiguration.inc.php";

      LSCOLORS = "HxGxDxDxbxDxDxababcxcx";
      LS_COLORS = "di=1;37:ln=1;36:so=1;33:pi=1;33:ex=31:bd=1;33:cd=1;33:su=30;41:sg=30;41:tw=32:ow=32";
      GREP_COLOR = "0;30;44";
      PHAN_COLOR_SCHEME = "code";
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
      t3Push = "git push origin HEAD:refs/for/main";
      t3Pull = "git pull --rebase origin main; git checkout main";
      t3Rollback = "git checkout main; git reset --hard origin/main";
      t3Clean = "t3Rollback && t3Pull";
    };

}
