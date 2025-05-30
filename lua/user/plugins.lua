local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"

    -- Cmp plugins
    use "hrsh7th/nvim-cmp"

    use "lervag/vimtex"
    use {'neoclide/coc.nvim', branch = 'release'}
    use "goolord/alpha-nvim"
    use 'Mofiqul/vscode.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
                current_line_blame_formatter = ' <author>, <author_time:%R> - <summary>',
            }
        end,
    }

    use {
        "micangl/cmp-vimtex",
        config = function()
            require('cmp_vimtex').setup()
        end,
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({triggers = {"<leader>"}})
        end,
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    use {
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        tag = "*",
        config = function()
            require("bufferline").setup {
                options = {
                    offsets = {{ filetype = "NvimTree", text = "EXPLORER", text_align = "center" }}
                }
            }
        end,
    }

    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    use {
        "ibhagwan/fzf-lua",
        requires = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('fzf-lua').setup({
                'max-perf',
                keymap = {
                    fzf = {
                        ["ctrl-z"] = "abort",
                        ["ctrl-f"] = "half-page-down",
                        ["ctrl-b"] = "half-page-up",
                        ["ctrl-a"] = "beginning-of-line",
                        ["ctrl-e"] = "end-of-line",
                        ["alt-a"]  = "toggle-all",
                        ["f3"]     = "toggle-preview-wrap",
                        ["f4"]     = "toggle-preview",
                        ["ctrl-d"] = "preview-page-down",
                        ["ctrl-u"] = "preview-page-up",
                        ["ctrl-q"] = "select-all+accept",
                    },
                },
            })
        end,
    }

    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup { map_cr = false }
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
