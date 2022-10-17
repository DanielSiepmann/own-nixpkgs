-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
    sync_root_with_cwd = false,
    auto_reload_on_write = false,
    filesystem_watchers = {
        enable = false,
    },
    view = {
        signcolumn = "yes",
        mappings = {
            list = {
                -- Keep original NERDtree mappings as I'm used to them
                { key = "x", action = "close_node", },
                { key = "X", action = "collapse_all", },
                { key = "O", action = "expand_all", },
                { key = "s", action = "vsplit", },
                { key = "C", action = "cd", },
                { key = "U", action = "dir_up", },
                { key = "I", action = "toggle_dotfiles", },
            },
        },
    },
    renderer = {
        add_trailing = true,
        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
            },
            glyphs = {
                symlink = "",
            },
        },
    },
    git = {
        enable = false,
    },
    filters = {
        dotfiles = true,
    },
    live_filter = {
        always_show_folders = false,
    },
})

-- TODO: Add x as mapping for close parent folder
