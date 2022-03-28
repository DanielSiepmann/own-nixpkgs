require('nvim-treesitter.configs').setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    -- ensure_installed = { "lua", "php", },

    -- Install languages synchronously (only applied to `ensure_installed`)
    -- sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {
            -- Seems not to be compatible, queries for unkown nodes
            -- Does not work right now, outdated?
            -- :checkhealth shows these errors:
            --# The following errors have been detected:
            -- - ERROR: nix(highlights): ...ed-0.7.0/share/nvim/runtime/lua/vim/treesitter/query.lua:172: query: invalid node type at position 268
            --   nix(highlights) is concatenated from the following files:
            --   | [ERROR]:"/nix/store/8pr8slfjc3yrj4m4fa14hjw1xkjl950b-vim-pack-dir/pack/home-manager/start/nvim-treesitter/queries/nix/highlights.scm", failed to load: ...ed-0.7.0/share/nvim/runtime/lua/vim/    treesitter/query.lua:172: query: invalid node type at position 268
            -- - ERROR: nix(locals): ...ed-0.7.0/share/nvim/runtime/lua/vim/treesitter/query.lua:172: query: invalid node type at position 16
            --   nix(locals) is concatenated from the following files:
            --   | [ERROR]:"/nix/store/8pr8slfjc3yrj4m4fa14hjw1xkjl950b-vim-pack-dir/pack/home-manager/start/nvim-treesitter/queries/nix/locals.scm", failed to load: ...ed-0.7.0/share/nvim/runtime/lua/vim/
            --   treesitter/query.lua:172: query: invalid node type at position 16
            -- - ERROR: nix(folds): ...ed-0.7.0/share/nvim/runtime/lua/vim/treesitter/query.lua:172: query: invalid node type at position 86
            --   nix(folds) is concatenated from the following files:
            --   | [ERROR]:"/nix/store/8pr8slfjc3yrj4m4fa14hjw1xkjl950b-vim-pack-dir/pack/home-manager/start/nvim-treesitter/queries/nix/folds.scm", failed to load: ...ed-0.7.0/share/nvim/runtime/lua/vim/
            --   treesitter/query.lua:172: query: invalid node type at position 86
            -- tree-sitter-nix
            "nix",
        },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
        -- additional_vim_regex_highlighting = { "" },
    },

    indent = {
        enable = true,
    },
}
