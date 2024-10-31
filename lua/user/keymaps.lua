-- Shorten function name

local options = function(description)
   return { desc = description, noremap = true, silent = true }
end

local function opts_ns(des)
   return { desc = des, noremap = true, silent = false }
end

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", options("Space"))

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
vim.keymap.set("n", "`", "~", options(""))
vim.keymap.set("n", "~", "`", options(""))
vim.keymap.set("n", ":", ";", { silent = false })
vim.keymap.set("n", ";", ":", { silent = false })
vim.keymap.set("n", "P", 'p', options("Paste after cursor"))
vim.keymap.set("n", "p", 'P', options("Paste before cursor"))
vim.keymap.set("n", "§", "<C-w>w", options("Switch windows"))
vim.keymap.set("n", "dd", '"_dd', options("Delete text without copying"))

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<S-C-Up>", ":resize -2<CR>", options("Resize window up"))
vim.keymap.set("n", "<S-C-Down>", ":resize +2<CR>", options("Resize window down"))
vim.keymap.set("n", "<S-C-Left>", ":vertical resize +2<CR>", options("Resize window left"))
vim.keymap.set("n", "<S-C-Right>", ":vertical resize -2<CR>", options("Resize window right"))

vim.keymap.set('n', '<leader>ro', ':%s///g<Left><Left>', opts_ns("Replace"))
vim.keymap.set('v', '<leader>ro', ':s///g<Left><Left>', opts_ns("Replace"))

-- QuickList
vim.keymap.set("n", "]q", "<cmd>cn<CR>", { desc = "Next quicklist match" })
vim.keymap.set("n", "[q", "<cmd>cp<CR>", { desc = "Previous quicklist match" })
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        vim.api.nvim_buf_set_keymap(
            0, 'n', 'dd', '<cmd>lua DELETE_QUICKFIX_ENTRY()<CR>',
            { noremap = true, silent = true }
        )
    end
})

-- Insert --
vim.keymap.set("i", '"', '""<Left>', {})
vim.keymap.set("i", "'", "''<Left>", {})
vim.keymap.set("i", "`", "``<Left>", {})
vim.keymap.set("i", "<", "<><Left>", {})
vim.keymap.set("i", "(", "()<Left>", {})
vim.keymap.set("i", "{", "{}<Left>", {})
vim.keymap.set("i", "[", "[]<Left>", {})

-- Visual --
vim.keymap.set("v", "<", "<gv", options("Stay in indent mode"))
vim.keymap.set("v", ">", ">gv", options("Stay in indent mode"))
vim.keymap.set("v", "p", '"_dP', options("Paste on top of text"))
vim.keymap.set("v", "<S-Up>", ":m .-2<CR>==", options("Move text up"))
vim.keymap.set("v", "<S-Down>", ":m .+1<CR>==", options("Move text down"))
vim.keymap.set("v", "d", '"_d', options("Delete text without copying"))

-- Visual Block --
vim.keymap.set("x", "<S-Up>", ":move '<-2<CR>gv-gv", options("Move text up"))
vim.keymap.set("x", "<S-Down>", ":move '>+1<CR>gv-gv", options("Move text down"))

-- Utilities
local utils = require("user.utils")
vim.keymap.set("n", "<leader>aa", utils.emily, { desc = "Appa, yip yip!!" })
vim.keymap.set("n", "<leader>at", utils.toggle_alpha, { desc = "Toggle Alpha screen" })

vim.keymap.set("n", "<C-x>", utils.bclose, { desc = "Buffer close" })
vim.keymap.set("n", "<tab>", utils.bnext, { desc = "Buffer goto next" })
vim.keymap.set("n", "<S-tab>", utils.bprevious, { desc = "Buffer goto prev" })
vim.keymap.set("n", "<leader>n", utils.relative_numbering, { desc = "Toggle relative numbering" })

vim.keymap.set("n", "<leader>cfn", utils.copy_filename, { desc = "Copy filename" })
vim.keymap.set("n", "<leader>cfp", utils.copy_full_path, { desc = "Copy file full path" })
vim.keymap.set("n", "<leader>cfr", utils.copy_relative_path, { desc = "Copy file relative path" })

vim.keymap.set("n", "<leader>wl", utils.remove_wl, { desc = "Remove white lines" })
vim.keymap.set("n", "<leader>ws", utils.toggle_ws, { desc = "Highlight trailing whitespaces" })

-- Git
vim.keymap.set("n", "<leader>gd", utils.git_diff, { desc = "Git diff current file" })
vim.keymap.set("n", "<leader>gb", utils.git_blame, { desc = "Git blame current line" })
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
vim.keymap.set("n", "<leader>gm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })

-- Cheatsheets
vim.keymap.set('n', '<leader>hm', utils.macro_help, options("Macro cheatsheet"))
vim.keymap.set('n', '<leader>hk', utils.mark_help, options("Marks cheatsheet"))
vim.keymap.set('n', '<leader>hr', utils.reg_help, options("Registers cheatsheet"))

vim.keymap.set('n', '<leader>ss', utils.save_session, options("Save Session"))
vim.keymap.set('n', '<leader>sw', utils.select_session, options("Select Session"))
vim.keymap.set('n', '<leader>sr', utils.remove_session, options("Remove Session"))

-- LSP
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.keymap.set("n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.keymap.set("n", "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
vim.keymap.set("n", "<leader>/", "gcc", { desc = "Comment toggle", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "Comment toggle", remap = true })

local M = {}

M.lsp_keymaps = function(bufnr)
    local opts = { noremap = true, silent = true }
    local buf_keymap = vim.api.nvim_buf_set_keymap
    buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_keymap(bufnr, "n", "gs", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
    buf_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_keymap(bufnr, "n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_keymap(bufnr, "n", "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    buf_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.telescope_keymaps = function()
    vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
    vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "telescope resume search" })
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
    vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
    vim.keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        { desc = "telescope find in current buffer" })
    vim.keymap.set("n", "<leader>fa",
        "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
        { desc = "telescope find all files" })
end

M.tree_keymaps = function()
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', options("Toggle Tree"))
end

return M
