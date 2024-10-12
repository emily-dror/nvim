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

vim.cmd [[
    augroup CursorShape
        autocmd!
        autocmd VimEnter * set guicursor=n-a-v-c:ver25
    augroup END
]]

-- Additional configurations for plugins can go here as well
require('nvim-autopairs').setup{}
vim.o.statusline = "%!v:lua.require('user.statusline')()"

