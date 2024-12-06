local api = require('nvim-tree.api')

require('nvim-tree').setup {
    update_cwd = true,
    git = { enable = false },
    update_focused_file = { enable = true },
    filesystem_watchers = { enable = false },
    filters = { custom = { '.DS_Store', '.cache' } },
    renderer = {
        group_empty = true,
        highlight_git = true,
        root_folder_modifier = ":t",
    },
    on_attach = function(bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', 'v', api.node.open.vertical, opts)
    end,
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "NvimTree",
    callback = function()
        vim.api.nvim_buf_set_keymap(
            0, 'n', '<leader>rr', '<cmd>NvimTreeRefresh<CR>',
            { noremap = true, silent = true }
        )
    end
})

vim.keymap.set(
    'n', '<leader>e', ':NvimTreeToggle<CR>',
    { desc = "Toggle Tree", noremap = true, silent = true }
)
