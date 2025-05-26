local sdk_remote = "edror@ntn-ads-edror:/auto/cag-sw/users/edror/sdk1/"

local function sync_file()
    local path = vim.fn.expand("%")
    vim.fn.system("scp " .. path .. " " .. sdk_remote .. path)
    print("Synced " .. path .. " to " .. sdk_remote)
end

vim.keymap.set("n", "<leader>y", sync_file, { desc = "Sync file to remote Leaba", silent = true })

local function darkness_shall_prevail()
    vim.cmd [[
        hi Normal guibg=#000000
        hi NormalNC guibg=#000000
        hi EndOfBuffer guibg=#000000
        hi SignColumn guibg=#000000
        hi VertSplit guibg=#000000

        hi BufferLineFill guibg=#000000
        hi BufferLineBackground guibg=#000000
        hi BufferLineSeparator guibg=#000000 guifg=#000000
        hi BufferLineTabSelected guibg=#000000
        hi BufferLineBufferSelected guibg=#000000
        hi BufferLineSeparatorSelected guibg=#000000 guifg=#000000
        hi BufferLineCloseButton guibg=#000000
        hi BufferLineCloseButtonVisible guibg=#000000
        hi BufferLineCloseButtonSelected guibg=#000000

        hi BufferLineBufferVisible guibg=#000000
        hi BufferLineBufferSelected guibg=#000000

        hi BufferLineIndicatorSelected guibg=#000000
        hi BufferLineModified guibg=#000000
        hi BufferLineModifiedVisible guibg=#000000
        hi BufferLineModifiedSelected guibg=#000000

        hi BufferLineDevIconLua guibg=#000000
    ]]
end

local function onedark_shall_prevail()
    vim.cmd [[
        hi Normal          guifg=#a7aab0 guibg=#232326
        hi EndOfBuffer     guifg=#232326 guibg=#232326
        hi SignColumn      guifg=#a7aab0 guibg=#232326
    ]]
end


darkness_shall_prevail()
