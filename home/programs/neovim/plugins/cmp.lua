require('cmp').setup({
    view = {
        entries = 'native',
    },

    experimental = {
        ghost_text = true,
    },

    sources = require('cmp').config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'omni' },
        { name = 'buffer' },
    }),
})
