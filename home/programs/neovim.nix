{ pkgs }:

let

  # The folder contains the expected `~/.config/nvim/` structure
  # This structure is the same for plugins.
  # I therefore just load this folder as plugin.
  configuration = pkgs.vimUtils.buildVimPlugin {
    name = "configuration";
    src = ./neovim/configuration;
  };

  colorscheme-smyckblue = pkgs.vimUtils.buildVimPlugin {
    name = "colorscheme-smyckblue";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/vim-colorscheme-smyckblue.git";
      rev = "v1.0.1";
      sha256 = "bBX3dzqKz6kTACfyAU4HH0UFVDYdyqLTvQdYTgWw8Jg=";
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

  syntax-mustache = pkgs.vimUtils.buildVimPlugin {
    name = "syntax-mustahce";
    src = pkgs.fetchFromGitHub {
      owner = "mustache";
      repo = "vim-mustache-handlebars";
      rev = "0153fe03a919add2d6cf2d41b2d5b6e1188bc0e0";
      sha256 = "lmYt+GKuXhbOhu3HufqIFE2DvzUYlk5vGqU6tpJ2yjY=";
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

  test = pkgs.vimUtils.buildVimPlugin {
    name = "test";
    src = pkgs.fetchFromGitHub {
      owner = "vim-test";
      repo = "vim-test";
      rev = "16a3b6da1bab42473d42d7e02d89d549d7a5e138";
      sha256 = "CVSTy/FeBgyzRK8NWDMiIynz7DRlFenruiCOjowYnMI=";
    };
    patches = [
      ./neovim/patches/disable_test_paratest.patch
    ];
  };

  telescope-ctags-outline = pkgs.vimUtils.buildVimPlugin {
    name = "telescope-ctags-outline";
    src = pkgs.fetchFromGitHub {
      owner = "fcying";
      repo = "telescope-ctags-outline.nvim";
      rev = "35b2df9545f72352502703ba06b7ab711fa25e51";
      sha256 = "e8QcD7H2unmoaLaN1JUxtOGQYBJGAXtfSnj8sW66ff4=";
    };
  };

in {
  enable = true;

  extraConfig = pkgs.lib.concatMapStringsSep "\n" (file: pkgs.lib.fileContents file) [
    ./neovim/init.vim

    ./neovim/config/functions.vim
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
    ./neovim/config/folderspecific/sac.vim
  ];

  extraPython3Packages = (ps: with ps; [
    # Dependency of sqlformat
    sqlparse
  ]);

  # TODO: Check out these plugins as additions / replacements:
  #
  # - https://github.com/rhysd/conflict-marker.vim/ (check out while resolving next merge conflict)
  # - https://github.com/sindrets/diffview.nvim/ (check out while reviewing PR next time?!)
  # - https://github.com/weilbith/nvim-code-action-menu/ Check with phpactor and lsp
  #
  # - https://github.com/hrsh7th/nvim-cmp (due to actual help of each parameter while adding values to function call)
  #
  # Alternatives:
  # - https://github.com/ms-jpq/chadtree/ (due to visual mode, is it worth it?)
  # - https://github.com/mfussenegger/nvim-dap Alternative to Vdebug, more modern and should work with firefox as well? But needs node …)
  #
  # Reviewed plugins until: https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix#L5810

  plugins = with pkgs.vimPlugins; [

    # My own plugins

    colorscheme-smyckblue
    neotags
    configuration
    syntax-typoscript

    # More UI related

    {
      plugin = nerdtree;
      config = pkgs.lib.fileContents ./neovim/plugins/nerdtree.vim;
    }

    {
      plugin = undotree;
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
      plugin = telescope-nvim;
      type = "lua";
      config = pkgs.lib.fileContents ./neovim/plugins/telescope.lua;
    }

    {
      plugin = telescope-ctags-outline;
      type = "lua";
      config = pkgs.lib.fileContents ./neovim/plugins/telescope-ctags-outline.lua;
    }

    # Syntax

    syntax-nix
    syntax-mustache
    i3config-vim
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
      plugin = vim-snipmate;
      # I didn't migrate snippets to new format, yet.
      config = ''
        let g:snipMate = { 'snippet_version' : 0 }
      '';
    }

    vim-fugitive
    vim-commentary
    vim-indent-object
    vim-textobj-comment

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

    # LSP (=Language Server Protocol)

    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = ''
        require'lspconfig'.phpactor.setup({
          cmd = {
            '${phpactor}/bin/phpactor',
            'language-server',
          },
        })
      '';
    }

    {
      plugin = lsp_signature-nvim;
      type = "lua";
      config = pkgs.lib.fileContents ./neovim/plugins/lsp-signature.lua;
    }

    # More related to testing, linting, …

    {
      plugin = ale;
      config = pkgs.lib.fileContents ./neovim/plugins/ale.vim;
    }

    {
      plugin = test;
      config = pkgs.lib.fileContents ./neovim/plugins/test.vim;
    }

    # Dependencies for other plugins

    vim-addon-mw-utils
    vim-textobj-user
    plenary-nvim
  ];
}
