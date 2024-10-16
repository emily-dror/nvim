local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlight then
        vim.api.nvim_exec(
        [[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
        false
        )
    end
end

-- Setup LSP
require('lspconfig').clangd.setup{
    capabilities = require('cmp_nvim_lsp').default_capabilities(),

    on_attach = function(client, bufnr)
        require("user.keymaps").lsp_keymaps(bufnr)
        lsp_highlight_document(client)
    end,

    cmd = {
        "clangd",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--clang-tidy"
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = require('lspconfig').util.root_pattern(
        "compile_commands.json",
        "compile_flags.txt",
        ".git"
    )
}

require('lspconfig').pyright.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    -- Your custom keybindings or settings
        lsp_highlight_document(client)
  end,
  filetypes = { "python" },  -- Ensure only Python files are targeted
  root_dir = require('lspconfig').util.root_pattern(".git", "setup.py", "pyproject.toml"),
}

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        focusable = true,
        source = "always",
        header = "",
        prefix = "",
    },
})

require('lspconfig').lua_ls.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = function(client, bufnr)
        lsp_highlight_document(client)
    end,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.pylint.with({
            command = "pylint",  -- The pylint command
            args = { "--from-stdin", "--output-format", "json", "$FILENAME" },
            diagnostics_format = "[pylint] #{m} (#{c})",
        }),
    },
})

