local telescope = require('telescope')
local actions = require('telescope.actions')
local actionsLayout = require('telescope.actions.layout')
local themes = require('telescope.themes')

telescope.setup({
    defaults = {
        layout_strategy = 'center',
        layout_config = {
            width = 0.6,
        },
        sorting_strategy = 'ascending',
        default_mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,

                ["<CR>"] = actions.select_default,
                ["<C-h>"] = actions.which_key,
                ["<C-v>"] = actions.select_vertical,

                ["<C-p>"] = actionsLayout.toggle_preview,
            },
        },

        preview = {
            hide_on_startup = true,
        },
    },
    extensions = {
        ['ui-select'] = {
            themes.get_dropdown({
            }),
        },
    },
})
telescope.load_extension('custom_runs')
telescope.load_extension('ui-select')
