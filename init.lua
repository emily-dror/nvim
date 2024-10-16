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

function delete_quickfix_entry()
    vim.cmd([[
        let curqfidx = line('.') - 1
        let qfl = getqflist()
        call remove(qfl, curqfidx)
        call setqflist(qfl)
        let new_idx = curqfidx
        if new_idx >= len(qfl)
            let new_idx = len(qfl)
        endif
        if new_idx >= 0
            exec new_idx + 1
        endif
    ]])
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'dd', '<cmd>lua delete_quickfix_entry()<CR>', { noremap = true, silent = true })
    end
})
