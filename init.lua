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
require "user.telescope"
require "user.templates"
require "user.nvim-window"
require "user.session_manager"
require "user.gitsigns"

require("ibl").setup {
    indent = { highlight = { "CursorColumn", "Whitespace", }, char = "" },
    whitespace = { highlight = { "CursorColumn", "Whitespace", }, remove_blankline_trail = false, },
    scope = { enabled = true },
}

