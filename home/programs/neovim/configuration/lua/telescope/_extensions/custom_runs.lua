local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local custom_runs = function(opts)
    opts = opts or {}

    local results = { 'CopyFileName', 'CopyRelativeFilePath', 'CopyFullFilePath' }

    pickers.new(opts, {
        prompt_title = 'Custom Runs',
        finder = finders.new_table {
            results = results
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.api.nvim_call_function(selection[1], {})
            end)
            return true
        end,
    }):find()
end

return telescope.register_extension({
    exports = { custom_runs = custom_runs },
})
