{ pkgs }:

let

  # The folder contains the expected `~/.config/nvim/` structure
  # This structure is the same for plugins.
  # I therefore just load this folder as plugin.
  configuration = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "configuration";
    src = ./neovim/configuration;
  };

  colorscheme-smyckblue = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "colorscheme-smyckblue";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/vim-colorscheme-smyckblue.git";
      rev = "v1.0.1";
      sha256 = "bBX3dzqKz6kTACfyAU4HH0UFVDYdyqLTvQdYTgWw8Jg=";
    };
  };

  neotags = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neotags";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/neotags.git";
      rev = "v0.3.0";
      sha256 = "uJ7cl+1Ngff0FKzjmh1i7O/PkNjPvPT+ZEHgceeZcz0=";
    };

    nativeBuildInputs = [
      pkgs.python3
    ];

    preInstall = ''
      rm -rf Dockerfile readme.rst .gitlab-ci.yml rplugin/test
      python -m compileall rplugin
    '';
  };

  syntax-typoscript = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "syntax-typoscript";
    src = pkgs.fetchgit {
      url = "https://gitea.daniel-siepmann.de/danielsiepmann/vim-syntax-typoscript.git";
      rev = "v1.1.0";
      sha256 = "ifdebcxzIskrs4FtIOtNc/L9lBS8oGeThJR+vccfVyc=";
    };
  };

  syntax-nix = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "syntax-nix";
    src = pkgs.fetchFromGitHub {
      owner = "LnL7";
      repo = "vim-nix";
      rev = "63b47b39c8d481ebca3092822ca8972e08df769b";
      sha256 = "wQzNXfE7JFalgiCQ2ksPAUyFKacmJV7mNKmKDe9jySI=";
    };
  };

  syntax-php = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "syntax-php";
    src = pkgs.fetchFromGitHub {
      owner = "StanAngeloff";
      repo = "php.vim";
      rev = "2ec2ab9fcc65bfc47c7ba6b3846903528188ceea";
      sha256 = "lgsaCU6Rzzynkd9SID0chjKaxgEWznrmEl133Syc6cY=";
    };
  };

  syntax-fluid = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "syntax-fluid";
    src = pkgs.fetchFromGitHub {
      owner = "mipmip";
      repo = "vim-fluid";
      rev = "cedc4ad871941e8f7134d1d71f9434f1bc3d93d5";
      sha256 = "LiS2Dqw1K1Fu5VfHQnxIBDxDzEarmSAUUavQcwHRDsQ=";
    };
  };

  syntax-mustache = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "syntax-mustahce";
    src = pkgs.fetchFromGitHub {
      owner = "mustache";
      repo = "vim-mustache-handlebars";
      rev = "0153fe03a919add2d6cf2d41b2d5b6e1188bc0e0";
      sha256 = "lmYt+GKuXhbOhu3HufqIFE2DvzUYlk5vGqU6tpJ2yjY=";
    };
  };

  ag = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "ag";
    src = pkgs.fetchFromGitHub {
      owner = "rking";
      repo = "ag.vim";
      rev = "c478f7973074f15bbf82c298a1678b4e23f1767a";
      sha256 = "jlR8NFG7IRCYiQ7ocQQCI2npAPujgQFZ6RpFX8zwTAA=";
    };
  };

  vdebug = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vdebug";
    src = pkgs.fetchFromGitHub {
      owner = "joonty";
      repo = "vdebug";
      rev = "v2.0.0";
      sha256 = "kobMC6TRFZcEbgFdOaBgXUzoeWQUrVzUKylN1N9nEnc=";
    };
  };

  sqlformat = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "sqlformat";
    src = pkgs.fetchFromGitHub {
      owner = "mpyatishev";
      repo = "vim-sqlformat";
      rev = "2a2a57d75865526f85d94bf769f4fd54d61c426b";
      sha256 = "LPnHcuh+jxEL8CZ1wizHqi3uzYYtIxzMqnE7y7mTrbE=";
    };
  };

  diff-fold = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "diff-fold";
    src = pkgs.fetchFromGitHub {
      owner = "sgeb";
      repo = "vim-diff-fold";
      rev = "48b4505c1b6f14ceb4e4be732aad337147ef36cd";
      sha256 = "M3CAUueEhLD0J6sLUpRkFv+vK4aGYO+Xnokxmn+VxqU=";
    };
  };

  phpactor = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "phpactor";
    version = "ad43a19480d016a140df7fbd8650439b4ff39d5b";
    src = pkgs.fetchzip {
      url = "https://daniel-siepmann.de/fileadmin/${pname}-${version}.tar.gz";
      sha256 = "sha256-oaewWfZ0WpZiXUVlWsxRlH6MYfPsAVhsxuAggcuQqVs=";
    };
  };

  neoterm = pkgs.vimUtils.buildVimPluginFrom2Nix {
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

  tagbar = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "tagbar";
    src = pkgs.fetchFromGitHub {
      owner = "majutsushi";
      repo = "tagbar";
      rev = "v2.7";
      sha256 = "Eg6xRwisopmBexqkWjRbSi9aQC4uCXbFO6SCK1LY+Ow=";
    };
  };

  test = pkgs.vimUtils.buildVimPluginFrom2Nix {
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

  telescope-ctags-outline = pkgs.vimUtils.buildVimPluginFrom2Nix {
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

  extraPython3Packages = (ps: with ps; [
    # Dependency of sqlformat
    sqlparse
  ]);

  # TODO: Check out these plugins as additions / replacements:

  # - https://github.com/glacambre/firenvim Give it another try, integrates neovim into firefox
  # - https://github.com/sindrets/diffview.nvim/ 

  # - https://github.com/weilbith/nvim-code-action-menu/ Check again in future, right now not of much useness on my setup.
  #
  # Alternatives:
  # - https://github.com/mfussenegger/nvim-dap Alternative to Vdebug, more modern and should work with firefox as well? But needs node …)
  # - https://github.com/nvim-neo-tree/neo-tree.nvim (General tree, not only filesystem, alternative to nerdtree but can also be used for buffers etc.)
  # - https://github.com/simrat39/symbols-outline.nvim/ Replacement for tagbar using lsp, combine with https://github.com/jose-elias-alvarez/null-ls.nvim once it supports Workspace Symbols / Document Symbol

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
    typescript-vim
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

    fugitive

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
      # TODO: Adjust templates: https://phpactor.readthedocs.io/en/master/reference/templates.html
      plugin = phpactor;
      config = ''
        let g:phpactorOmniError = v:true
        let g:phpactorPhpBin = "${pkgs.php74}/bin/php"
      '';
    }

    # LSP (=Language Server Protocol)

    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = ''
        require('lspconfig').phpactor.setup({
          cmd = {
            '${pkgs.php74}/bin/php',
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
      config = pkgs.lib.fileContents(./neovim/plugins/ale.vim)
        # Keep line break as fileContents strips last EOL
        + ''

          let g:ale_yaml_yamllint_executable = '${pkgs.yamllint}/bin/yamllint'
          let g:ale_xml_xmllint_executable = '${pkgs.libxml2}/bin/xmllint'
          let g:ale_gitcommit_gitlint_executable = '${pkgs.gitlint}/bin/gitlint'
          let g:ale_nix_statix_check_executable = '${pkgs.statix}/bin/statix'
        '';
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
