{ pkgs }:

{
  enable = true;

  userName = "Daniel Siepmann";
  userEmail = "coding@daniel-siepmann.de";

  signing = {
    key = "15560EF4";
    signByDefault = true;
  };

  aliases = {
    c = "checkout";
    ss = "show -s";

    s = "status -s";
    dc = "diff --cached";

    sc = "switch -c";
    st = "switch -t";

    com = "commit";

    ri = "rebase -i";
    rc = "rebase --continue";

    fap = "fetch --all --prune";
    rh = "reset --hard";
    cp = "cherry-pick";

    lg = "log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
  };

  ignores = [
    # Some files which might be generated by system or tools
    "*~"
    "*.swp"
    "*.swn"
    "*.swo"
    "*.orig"
    "*.rej"
    "*.pyc"
    "*.bak"
    "*/tags"
    "/tags"
    "*.~lock.*#"
    # As I'm using Makefiles in many projects for my own confidence
    "Makefile"

    # Some generics which occur in some projects
    "build/"
    "logs/"

    # PHP Specific
    ".phpunit.result.cache"
    "phpcs.xml"

    # TYPO3 documentation specific
    "Documentation-GENERATED-temp*/"
  ];

  # TODO: Check out these additions
  # - https://github.com/dandavison/delta - A syntax-highlighting pager for git, diff, and grep output 

  extraConfig = {
    advice = {
      detachedHead = false;
    };

    branch = {
      autosetuprebase = "always";
    };

    color = {
      diff = "auto";
      status = "auto";
      branch = "auto";
      interactive = "auto";
      ui = "auto";
    };

    pager = {
      branch = false;
      show = false;
      log = toString pkgs.less + "/bin/less";
      diff = toString pkgs.less + "/bin/less";
    };

    grep = {
      lineNumber = true;
    };

    help = {
      autocorrect = 1;
    };

    push = {
      default = "current";
      gpgSign = "if-asked";
    };

    init = {
      defaultBranch = "main";
    };

    merge = {
      ff = true;
      tool = "nvimdiff4";
    };

    "mergetool \"nvimdiff4\"" = {
      cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J' -c 'diffoff'";
    };
  };
}
