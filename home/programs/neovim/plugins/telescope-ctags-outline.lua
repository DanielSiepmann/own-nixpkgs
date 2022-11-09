require('telescope').setup({
    extensions = {
        ctags_outline = {
            ctags = { 'ctags' },
            ft_opt = {
                css = '--css-types=vcit',
                fluid = '--xml-types=si',
                markdown = '--Markdown-types=csStT',
                rst = '--reStructuredText-types=csSt',
                sql = '--SQL-types=tE',
                xml = '--xml-types=ci',
                yaml = '--Yaml-types=t',
            },
        },
    },
})

require('telescope').load_extension('ctags_outline')
