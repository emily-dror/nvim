require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.bufferline"
require "user.statusline"
require "user.alpha"
require "user.nvim-tree"
require "user.which-key"
require "user.templates"
require "user.nvim-window"
require "user.session_manager"
require "user.gitsigns"

require("ibl").setup {
    indent = { highlight = { "CursorColumn", "Whitespace", }, char = "" },
    whitespace = { highlight = { "CursorColumn", "Whitespace", }, remove_blankline_trail = false, },
    scope = { enabled = true },
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
