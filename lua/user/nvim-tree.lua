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
    }
}

require("user.keymaps").tree_keymaps()
