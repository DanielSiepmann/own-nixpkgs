require("fzf-lua").setup({
    fzf_bin = "fzf-tmux",
    fzf_opts = {
        ["--border"] = "rounded",
    },
    fzf_tmux_opts = {
        ["-p"] = "",
        ["-y"] = "1",
        ["-w"] = "95%",
        ["-h"] = "75%",
    },
    winopts = {
        preview = {
            hidden = "hidden", -- I don't like a preview, keep space for selection
        },
    },
})

require("fzf-lua").register_ui_select()
