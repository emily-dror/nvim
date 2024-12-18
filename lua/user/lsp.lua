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

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
cmp_capabilities.textDocument.semanticHighlighting = false

-- Setup LSP
require('lspconfig').clangd.setup{
    capabilities = cmp_capabilities,

    on_attach = function(client, bufnr)
        require("user.keymaps").lsp_keymaps(bufnr)
        client.server_capabilities.semanticTokensProvider = nil
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
    capabilities = cmp_capabilities,
    on_attach = function(client, bufnr)
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
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}

require('lspconfig').prolog_ls.setup {
    cmd = {
        "swipl",
        "-g", "use_module(library(lsp_server)).",
        "-g", "lsp_server:main",
        "-t", "halt",
        "--", "stdio"
    },
    filetypes = { "prolog" },
    root_dir = require('lspconfig').util.root_pattern(".git", "*.pl"),
}

require('lspconfig').bashls.setup {
    capabilities = cmp_capabilities,
    on_attach = function(client, bufnr)
        lsp_highlight_document(client)
    end,
    cmd = { 'bash-language-server', 'start' },
    filetypes = { "sh" },
}
