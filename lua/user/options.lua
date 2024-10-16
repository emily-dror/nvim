-- :help options
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = false                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                  -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications

vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

-- Color Column
vim.opt.colorcolumn = "100"

-- VimTex
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_method = "skim"

-- Set the global status line
vim.o.laststatus = 3

-- Whitespace
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "darkred", bg = "darkred" })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e"
})

vim.o.background = 'dark'  -- For dark mode
vim.cmd [[colorscheme vscode]]

require('vscode').setup({
  transparent = true,        -- Set to true if you want transparent background
  italic_comments = true,     -- Enable italic comments
  underline_links = true,
  disable_nvimtree_bg = true,
})

vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

