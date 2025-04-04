require("ibl").setup()
require("barbecue").setup()
require("bufferline").setup()
require("which-key").setup({
    triggers = {"<leader>"}
})
require("nvim-autopairs").setup { map_cr = false }
require('gitsigns').setup {
    current_line_blame_formatter = ' <author>, <author_time:%R> - <summary>',
}
require('fzf-lua').setup({
    'max-perf',
    keymap = {
        fzf = {
            ["ctrl-z"] = "abort",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-b"] = "half-page-up",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["alt-a"]  = "toggle-all",
            ["f3"]     = "toggle-preview-wrap",
            ["f4"]     = "toggle-preview",
            ["ctrl-d"] = "preview-page-down",
            ["ctrl-u"] = "preview-page-up",
            ["ctrl-q"] = "select-all+accept",
        },
    },
})
