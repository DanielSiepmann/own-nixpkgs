local telescopeActions = require "telescope.actions"
local telescopeActionsLayout = require "telescope.actions.layout"
require('telescope').setup({
    defaults = {
        layout_strategy = 'center',
        layout_config = {
            width = 0.6,
        },
        sorting_strategy = 'ascending',
        default_mappings = {
            i = {
                ["<C-j>"] = telescopeActions.move_selection_next,
                ["<C-k>"] = telescopeActions.move_selection_previous,
                ["<C-c>"] = telescopeActions.close,

                ["<CR>"] = telescopeActions.select_default,
                ["<C-h>"] = telescopeActions.which_key,
                ["<C-v>"] = telescopeActions.select_vertical,

                ["<C-p>"] = telescopeActionsLayout.toggle_preview,
            },
        },

        preview = {
            hide_on_startup = true,
        },
    },
})

require('telescope').load_extension('custom_runs')
