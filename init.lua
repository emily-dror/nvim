require "user.options"
require "user.keymaps"
require "user.coc"
require "user.treesitter"
require "user.statusline"
require "user.alpha"
require "user.nvim-tree"
require "user.templates"
require "user.nvim-window"
require "user.session_manager"


-- Set termguicolors for better colors
vim.opt.termguicolors = true

-- Setup the plugin
require("nvim-tree").setup()
require("bufferline").setup()
require('gitsigns').setup {
    current_line_blame_formatter = ' <author>, <author_time:%R> - <summary>',
}
require("which-key").setup({triggers = {"<leader>"}})
require("ibl").setup()
require("barbecue").setup()
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
require("nvim-autopairs").setup { map_cr = false }


