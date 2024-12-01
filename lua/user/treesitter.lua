require'nvim-treesitter.configs'.setup {
    modules = {},
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "markdown",
        "markdown_inline",
        "latex",
        "json"
    },

    sync_install = true,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = false,
        extended_mode = true,
        max_file_lines = nil,
    },
    playground = {
        enable = true,
    }
}

vim.api.nvim_set_hl(0, "@function.macro", { fg = '#c586c0' })
vim.api.nvim_set_hl(0, "@keyword.directive.c", { fg = '#c586c0' })
vim.api.nvim_set_hl(0, "@keyword.directive.define.c", { fg = '#c586c0' })
vim.api.nvim_set_hl(0, "@keyword.type.c", { fg = '#4ec9b0' })
vim.api.nvim_set_hl(0, "@type.builtin.c", { fg = '#4ec9b0' })
vim.api.nvim_set_hl(0, "@constant.macro.c", { fg = '#4fc1ff' })

vim.api.nvim_set_hl(0, "@keyword.directive.cpp", { fg = '#c586c0' })
vim.api.nvim_set_hl(0, "@keyword.directive.define.cpp", { fg = '#c586c0' })
vim.api.nvim_set_hl(0, "@keyword.type.cpp", { fg = '#4ec9b0' })
vim.api.nvim_set_hl(0, "@type.builtin.cpp", { fg = '#4ec9b0' })
vim.api.nvim_set_hl(0, "@constant.macro.cpp", { fg = '#4fc1ff' })
