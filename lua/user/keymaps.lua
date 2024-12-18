
local opts = function(description, sil, buf)
    buf = buf or false
    return { desc = description, noremap = true, silent = sil, buffer = buf }
end

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", opts("Space"))

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
vim.keymap.set("n", "§", "~", opts(""))
vim.keymap.set("n", "±", "`", opts(""))
vim.keymap.set("n", ";", ":", { silent = false })
vim.keymap.set("n", "+", '<C-a>', opts("Increment number"))
vim.keymap.set("n", "-", '<C-x>', opts("Decrement number"))
vim.keymap.set("n", "<BS>", '"_dd', opts("Delete text without copying"))

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<S-C-Up>", ":resize -2<CR>", opts("Resize window up", true))
vim.keymap.set("n", "<S-C-Down>", ":resize +2<CR>", opts("Resize window down", true))
vim.keymap.set("n", "<S-C-Left>", ":vertical resize +2<CR>", opts("Resize window left", true))
vim.keymap.set("n", "<S-C-Right>", ":vertical resize -2<CR>", opts("Resize window right", true))
vim.keymap.set("n", "\\", function() require('user.nvim-window').pick() end , opts("Pick window"))

vim.keymap.set('n', '<leader>r', ':%s///g<Left><Left>', opts("Replace", false))
vim.keymap.set('v', '<leader>r', ':s///g<Left><Left>', opts("Replace", false))

vim.keymap.set("n", "];", ";", { silent = false })
vim.keymap.set("n", "[;", ",", { silent = false })

-- Visual --
vim.keymap.set("v", "<", "<gv", opts("Stay in indent mode"))
vim.keymap.set("v", ">", ">gv", opts("Stay in indent mode"))
vim.keymap.set("v", "p", '"_dP', opts("Paste on top of text"))
vim.keymap.set("v", "<BS>", '"_d', opts("Delete text without copying"))
vim.keymap.set("v", "<S-Up>", ":m .-2<CR>==", opts("Move text up", true))
vim.keymap.set("v", "<S-Down>", ":m .+1<CR>==", opts("Move text down", true))

-- Visual Block --
vim.keymap.set("x", "<S-Up>", ":move '<-2<CR>gv-gv", opts("Move text up", true))
vim.keymap.set("x", "<S-Down>", ":move '>+1<CR>gv-gv", opts("Move text down", true))

-- Utilities
local utils = require("user.utils")
vim.keymap.set("n", "<leader>aa", utils.emily, { desc = "Appa, yip yip!!" })
vim.keymap.set("n", "<leader>at", utils.toggle_alpha, { desc = "Toggle Alpha screen" })
vim.keymap.set("n", "<leader>gd", utils.git_diff, { desc = "Git diff current file" })

vim.keymap.set("n", "<C-x>", utils.bclose, { desc = "Buffer close" })
vim.keymap.set("n", "<tab>", utils.bnext, { desc = "Buffer goto next" })
vim.keymap.set("n", "<S-tab>", utils.bprevious, { desc = "Buffer goto prev" })

vim.keymap.set("n", "<leader>cn", utils.copy_filename, { desc = "Copy filename" })
vim.keymap.set("n", "<leader>cp", utils.copy_full_path, { desc = "Copy file full path" })
vim.keymap.set("n", "<leader>cr", utils.copy_relative_path, { desc = "Copy file relative path" })

-- QuickList
vim.keymap.set("n", "]q", "<cmd>cn<CR>", { desc = "Next quicklist match" })
vim.keymap.set("n", "[q", "<cmd>cp<CR>", { desc = "Previous quicklist match" })
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function() vim.keymap.set( 'n', '<BS>', utils.qf_del_entry, opts("", true, 0)) end
})

-- Cheatsheets
vim.keymap.set('n', '<leader>hm', utils.macro_help, opts("Macro cheatsheet"))
vim.keymap.set('n', '<leader>hk', utils.mark_help, opts("Marks cheatsheet"))
vim.keymap.set('n', '<leader>hr', utils.reg_help, opts("Registers cheatsheet"))
vim.keymap.set('n', '<leader>hd', utils.markdown_help, opts("Markdown cheatsheet"))

-- Wrapper
vim.keymap.set('v', '(', function() utils.wrap_selection("(", ")") end, opts("Wrap ()"))
vim.keymap.set('v', '[', function() utils.wrap_selection("[", "]") end, opts("Wrap []"))
vim.keymap.set('v', '{', function() utils.wrap_selection("{", "}") end, opts("Wrap {}"))
vim.keymap.set('v', '`', function() utils.wrap_selection("`", "`") end, opts("Wrap ``"))
vim.keymap.set('v', "'", function() utils.wrap_selection("'", "'") end, opts("Wrap ''"))
vim.keymap.set('v', '"', function() utils.wrap_selection('"', '"') end, opts("Wrap \"\""))

-- Git
local gitsigns = require('gitsigns')
vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
        else
            gitsigns.nav_hunk('next')
        end
    end,
    { desc = "Toggle Deleted" }
)
vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
        else
            gitsigns.nav_hunk('prev')
        end
    end,
    { desc = "Toggle Deleted" }
)
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
vim.keymap.set({'o', 'x'}, 'ih',  ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select Hunk" })

-- Session Manager
local manager = require("user.session_manager")
vim.keymap.set('n', '<leader>ss', manager.save_session, opts("Save Session"))
vim.keymap.set('n', '<leader>sw', manager.show_session_manager, opts("Show Session Manager"))

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

vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "find marks" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "help page" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "live grep" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", { desc = "resume search" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "find buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "find files" })
vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "find oldfiles" })

return M
