-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local api = require('nvim-tree.api')

-- Function to set custom key mappings
local function on_attach(bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'v', api.node.open.vertical, opts)
end

require('nvim-tree').setup {
    on_attach = on_attach,
    update_cwd = true,
    renderer = {
        group_empty = true,
        highlight_git = true,
        root_folder_modifier = ":t",  -- This makes the paths relative
    },
    update_focused_file = {
        enable = true,       -- Enable the feature
    },
    filesystem_watchers = {
        enable = false,  -- disables automatic file system watching
    },
    git = {
        enable = false
    },
    filters = {
        custom = { '.git', 'build', '.cache' }  -- Add folders you want to ignore
    },
    view = {
        adaptive_size = true,
    }
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rr', '<cmd>NvimTreeRefresh<CR>', { noremap = true, silent = true })
  end
})

require("user.keymaps").tree_keymaps()
