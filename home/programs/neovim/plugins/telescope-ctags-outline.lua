require('telescope').setup({
    extensions = {
        ctags_outline = {
            ctags = { 'ctags' },
            ft_opt = {
                css = '--css-types=vcit',
                xml = '--xml-types=ci',
                rst = '--reStructuredText-types=csSt',
                markdown = '--Markdown-types=csStT',
                fluid = '--xml-types=si',
                yaml = '--yaml-types=t',
            },
        },
    },
})

require('telescope').load_extension('ctags_outline')
