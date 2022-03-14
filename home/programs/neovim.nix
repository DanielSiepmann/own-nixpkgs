{ pkgs }:

let

  configuration = pkgs.vimUtils.buildVimPlugin {
    name = "configuration";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/vim-configuration.git";
      rev = "53736aec92e92dc600694e90de9a8b7dabc90dd0";
      sha256 = "9hRXvgtKknFd4Rng+BsedJvwU7sFBDLZmSEGteMroGc=";
    };
  };

  colorscheme-smyckblue = pkgs.vimUtils.buildVimPlugin {
    name = "colorscheme-smyckblue";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/vim-colorscheme-smyckblue.git";
      rev = "v1.0.0";
      sha256 = "UPh15fMTq/HHnunq+xy8YGOlqfgUaqHuTEE5kQ3j3bM=";
    };
  };

  snippets = pkgs.vimUtils.buildVimPlugin {
    name = "snippets";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/vim-snippets.git";
      rev = "v1.0.0";
      sha256 = "23XR2YysdgUW+xKS79tAYP+Hjka0YolLaHlYiD0Hyx8=";
    };
  };

  neotags = pkgs.vimUtils.buildVimPlugin {
    name = "neotags";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/neotags.git";
      rev = "v0.3.0";
      sha256 = "uJ7cl+1Ngff0FKzjmh1i7O/PkNjPvPT+ZEHgceeZcz0=";
    };
  };

  # TODO: Update, compare with other forks, move to Gitea
  syntax-typoscript = pkgs.vimUtils.buildVimPlugin {
    name = "syntax-typoscript";
    src = pkgs.fetchFromGitHub {
      owner = "DanielSiepmann";
      repo = "vim.typoscript";
      rev = "286bc376b55b0d0d0adc6e7ccfa6a75719437120";
      sha256 = "BPvKwcTo/OL9VkNJ9dv8hs4nlVkxMI6pdkZXXAKBMWs=";
    };
  };

  syntax-nix = pkgs.vimUtils.buildVimPlugin {
    name = "syntax-nix";
    src = pkgs.fetchFromGitHub {
      owner = "LnL7";
      repo = "vim-nix";
      rev = "63b47b39c8d481ebca3092822ca8972e08df769b";
      sha256 = "wQzNXfE7JFalgiCQ2ksPAUyFKacmJV7mNKmKDe9jySI=";
    };
  };

  syntax-php = pkgs.vimUtils.buildVimPlugin {
    name = "syntax-php";
    src = pkgs.fetchFromGitHub {
      owner = "StanAngeloff";
      repo = "php.vim";
      rev = "2ec2ab9fcc65bfc47c7ba6b3846903528188ceea";
      sha256 = "lgsaCU6Rzzynkd9SID0chjKaxgEWznrmEl133Syc6cY=";
    };
  };

  syntax-fluid = pkgs.vimUtils.buildVimPlugin {
    name = "syntax-fluid";
    src = pkgs.fetchFromGitHub {
      owner = "mipmip";
      repo = "vim-fluid";
      rev = "cedc4ad871941e8f7134d1d71f9434f1bc3d93d5";
      sha256 = "LiS2Dqw1K1Fu5VfHQnxIBDxDzEarmSAUUavQcwHRDsQ=";
    };
  };

  ag = pkgs.vimUtils.buildVimPlugin {
    name = "ag";
    src = pkgs.fetchFromGitHub {
      owner = "rking";
      repo = "ag.vim";
      rev = "c478f7973074f15bbf82c298a1678b4e23f1767a";
      sha256 = "jlR8NFG7IRCYiQ7ocQQCI2npAPujgQFZ6RpFX8zwTAA=";
    };
  };

  vdebug = pkgs.vimUtils.buildVimPlugin {
    name = "vdebug";
    src = pkgs.fetchFromGitHub {
      owner = "joonty";
      repo = "vdebug";
      rev = "v2.0.0";
      sha256 = "kobMC6TRFZcEbgFdOaBgXUzoeWQUrVzUKylN1N9nEnc=";
    };
  };

  sqlformat = pkgs.vimUtils.buildVimPlugin {
    name = "sqlformat";
    src = pkgs.fetchFromGitHub {
      owner = "mpyatishev";
      repo = "vim-sqlformat";
      rev = "2a2a57d75865526f85d94bf769f4fd54d61c426b";
      sha256 = "LPnHcuh+jxEL8CZ1wizHqi3uzYYtIxzMqnE7y7mTrbE=";
    };
  };

  diff-fold = pkgs.vimUtils.buildVimPlugin {
    name = "diff-fold";
    src = pkgs.fetchFromGitHub {
      owner = "sgeb";
      repo = "vim-diff-fold";
      rev = "48b4505c1b6f14ceb4e4be732aad337147ef36cd";
      sha256 = "M3CAUueEhLD0J6sLUpRkFv+vK4aGYO+Xnokxmn+VxqU=";
    };
  };

  phpactor = pkgs.vimUtils.buildVimPlugin {
    name = "phpactor";
    src = pkgs.fetchzip {
      url = "https://daniel-siepmann.de/fileadmin/phpactor-0.18.0.tar.gz";
      sha256 = "1XHqKxBXcFPt2P/N2drr8EkBsg0Hu94Vjq0my+aj614=";
    };
  };

  neoterm = pkgs.vimUtils.buildVimPlugin {
    name = "neoterm";
    src = pkgs.fetchFromGitHub {
      owner = "kassio";
      repo = "neoterm";
      rev = "e78179a9ceb98de8d0c37bdda435a5deab4d5e71";
      sha256 = "0w962xfcgigdw41wblrv1l55xki0kl5vwkdbm6jlr44hzii0nhgz";
    };
    patches = [
      ./neovim/patches/disable_neoterm_repl.patch
    ];
  };

  tagbar = pkgs.vimUtils.buildVimPlugin {
    name = "tagbar";
    src = pkgs.fetchFromGitHub {
      owner = "majutsushi";
      repo = "tagbar";
      rev = "v2.7";
      sha256 = "Eg6xRwisopmBexqkWjRbSi9aQC4uCXbFO6SCK1LY+Ow=";
    };
  };

in {
  enable = true;

  extraConfig = pkgs.lib.concatMapStringsSep "\n" (file: pkgs.lib.fileContents file) [
    ./neovim/init.vim

    ./neovim/config/functions.vim
    ./neovim/config/grepping.vim
    ./neovim/config/indentation.vim
    ./neovim/config/mappings.vim
    ./neovim/config/searching.vim
    ./neovim/config/statusline.vim
    ./neovim/config/undo.vim
    ./neovim/config/wildignore.vim

    ./neovim/config/autocommands/basics.vim
    ./neovim/config/autocommands/gitdiff.vim
    ./neovim/config/autocommands/typo3.vim
    ./neovim/config/autocommands/vdebug.vim

    ./neovim/config/folderspecific/reuter.vim
  ];

  plugins = [

    # My own plugins

    colorscheme-smyckblue
    neotags
    configuration
    snippets
    syntax-typoscript

    # More UI related

    {
      plugin = pkgs.vimPlugins.nerdtree;
      config = pkgs.lib.fileContents ./neovim/plugins/nerdtree.vim;
    }

    {
      plugin = pkgs.vimPlugins.undotree;
      config = pkgs.lib.fileContents ./neovim/plugins/undotree.vim;
    }

    {
      # Use pinned to 2.7 as I don't need any of the new features.
      # Instead they make it hard to only show what I'm interested in within PHP files.
      # As they changed the building with nested structures.
      plugin = tagbar;
      config = pkgs.lib.fileContents ./neovim/plugins/tagbar.vim;
    }

    {
      plugin = pkgs.vimPlugins.ctrlp-vim;
      config = pkgs.lib.fileContents ./neovim/plugins/ctrlp.vim;
    }

    # Syntax

    syntax-nix
    syntax-fluid
    {
      plugin = syntax-php;
      config = pkgs.lib.fileContents ./neovim/plugins/php.vim;
    }

    # Adding features

    ag
    sqlformat
    diff-fold

    {
      plugin = pkgs.vimPlugins.vim-snipmate;
      config = ''
        let g:snipMate = { 'snippet_version' : 0 }
      '';
    }

    pkgs.vimPlugins.vim-fugitive
    pkgs.vimPlugins.vim-commentary
    pkgs.vimPlugins.vim-indent-object
    pkgs.vimPlugins.vim-textobj-comment

    {
      plugin = vdebug;
      config = pkgs.lib.fileContents ./neovim/plugins/vdebug.vim;
    }

    {
      # Seems to be broken: https://github.com/kassio/neoterm/issues/338
      # Therefore I install my own version where this bug is disabled
      plugin = neoterm;
      config = pkgs.lib.fileContents ./neovim/plugins/neoterm.vim;
    }

    {
      plugin = phpactor;
      config = ''
        let g:phpactorOmniError = v:true
        let g:phpactorPhpBin = "${pkgs.php80}/bin/php"
      '';
    }

    # More related to testing, linting, …

    {
      plugin = pkgs.vimPlugins.ale;
      config = pkgs.lib.fileContents ./neovim/plugins/ale.vim;
    }

    {
      plugin = pkgs.vimPlugins.syntastic;
      config = pkgs.lib.fileContents ./neovim/plugins/syntastic.vim;
    }

    {
      plugin = pkgs.vimPlugins.vim-test;
      config = pkgs.lib.fileContents ./neovim/plugins/test.vim;
    }

    # Dependencies for other plugins

    pkgs.vimPlugins.vim-addon-mw-utils
    pkgs.vimPlugins.vim-textobj-user
  ];
}
