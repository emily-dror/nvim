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
vim.keymap.set("", "`", "~", options(""))
vim.keymap.set("", "~", "`", options(""))
vim.keymap.set("", ":", ";", { silent = false })
vim.keymap.set("", ";", ":", { silent = false })
vim.keymap.set("n", "+", '<C-a>', options("Increment number"))
vim.keymap.set("n", "-", '<C-x>', options("Decrement number"))
vim.keymap.set("n", "dd", '"_dd', options("Delete text without copying"))

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<S-C-Up>", ":resize -2<CR>", options("Resize window up"))
vim.keymap.set("n", "<S-C-Down>", ":resize +2<CR>", options("Resize window down"))
vim.keymap.set("n", "<S-C-Left>", ":vertical resize +2<CR>", options("Resize window left"))
vim.keymap.set("n", "<S-C-Right>", ":vertical resize -2<CR>", options("Resize window right"))
vim.keymap.set("n", "§", ":lua require('user.nvim-window').pick()<CR>", { desc = "window" })

vim.keymap.set('n', '<leader>r', ':%s///g<Left><Left>', opts_ns("Replace"))
vim.keymap.set('v', '<leader>r', ':s///g<Left><Left>', opts_ns("Replace"))

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
vim.keymap.set("i", ',"', '""<Left>', {})
vim.keymap.set("i", ",'", "''<Left>", {})
vim.keymap.set("i", ",`", "``<Left>", {})
vim.keymap.set("i", ",<", "<><Left>", {})
vim.keymap.set("i", ",(", "()<Left>", {})
vim.keymap.set("i", ",{", "{}<Left>", {})
vim.keymap.set("i", ",[", "[]<Left>", {})

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
vim.keymap.set("n", "<leader>gd", utils.git_diff, { desc = "Git diff current file" })

vim.keymap.set("n", "<C-x>", utils.bclose, { desc = "Buffer close" })
vim.keymap.set("n", "<tab>", utils.bnext, { desc = "Buffer goto next" })
vim.keymap.set("n", "<S-tab>", utils.bprevious, { desc = "Buffer goto prev" })
vim.keymap.set("n", "<leader>n", utils.relative_numbering, { desc = "Toggle relative numbering" })

vim.keymap.set("n", "<leader>cn", utils.copy_filename, { desc = "Copy filename" })
vim.keymap.set("n", "<leader>cp", utils.copy_full_path, { desc = "Copy file full path" })
vim.keymap.set("n", "<leader>cr", utils.copy_relative_path, { desc = "Copy file relative path" })

vim.keymap.set("n", "<leader>wl", utils.remove_wl, { desc = "Remove white lines" })
vim.keymap.set("n", "<leader>ws", utils.toggle_ws, { desc = "Highlight trailing whitespaces" })

-- Cheatsheets
vim.keymap.set('n', '<leader>hm', utils.macro_help, options("Macro cheatsheet"))
vim.keymap.set('n', '<leader>hk', utils.mark_help, options("Marks cheatsheet"))
vim.keymap.set('n', '<leader>hr', utils.reg_help, options("Registers cheatsheet"))
vim.keymap.set('n', '<leader>hd', utils.markdown_help, options("Markdown cheatsheet"))

-- Wrapper
vim.keymap.set('v', '(', function() utils.wrap_selection("(", ")") end, options("Wrap ()"))
vim.keymap.set('v', '[', function() utils.wrap_selection("[", "]") end, options("Wrap []"))
vim.keymap.set('v', '{', function() utils.wrap_selection("{", "}") end, options("Wrap {}"))
vim.keymap.set('v', '`', function() utils.wrap_selection("`", "`") end, options("Wrap ``"))
vim.keymap.set('v', "'", function() utils.wrap_selection("'", "'") end, options("Wrap ''"))
vim.keymap.set('v', '"', function() utils.wrap_selection('"', '"') end, options("Wrap \"\""))


-- Session Manager
local manager = require("user.session_manager")
vim.keymap.set('n', '<leader>ss', manager.save_session, options("Save Session"))
vim.keymap.set('n', '<leader>sw', manager.show_session_manager, options("Show Session Manager"))

vim.keymap.set("n", "<leader>il", "<cmd>IBLToggle<CR>", { desc = "IBLToggle" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("n", "<leader>ll", "<cmd>RenderMarkdown toggle<CR>", {})
    end,
})

-- LSP
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
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

vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "telescope help page" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "telescope live grep" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", { desc = "telescope resume search" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "telescope find buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "telescope find oldfiles" })

M.tree_keymaps = function()
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', options("Toggle Tree"))
end

M.git_signs = function(gitsigns)
    vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = "Stage Hunk" })
    vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset Hunk" })
    vim.keymap.set('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage Hunk" })
    vim.keymap.set('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset Hunk" })
    vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { desc = "Stage Buffer" })
    vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = "Unod Stage Buffer" })
    vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = "Reset Buffer" })
    vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = "Preview Hunk" })
    vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, { desc = "Blame Line" })
    vim.keymap.set('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
    vim.keymap.set('n', '<leader>gD', gitsigns.toggle_deleted, { desc = "Toggle Deleted" })
end

return M
