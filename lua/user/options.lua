vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "100"
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.shortmess:append "c"

vim.o.laststatus = 3
vim.o.statusline = "%!v:lua.require('user.statusline')()"

vim.cmd [[colo vscode]]
vim.cmd [[set whichwrap+=<,>,[,],h,l]]
vim.cmd [[
    au BufWritePre * :%s/\s\+$//e
]]
vim.cmd [[
    aug CursorShape
    au!
    au VimEnter * set guicursor=n-a-v-c:ver25
    aug END
]]
