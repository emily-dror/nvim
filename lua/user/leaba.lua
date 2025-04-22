local sdk_remote = "edror@ntn-ads-edror:/auto/cag-sw/users/edror/sdk/"

local function sync_file()
    local path = vim.fn.expand("%")
    vim.fn.system("scp " .. path .. " " .. sdk_remote .. path)
    print("Synced " .. path .. " to " .. sdk_remote)
end

vim.keymap.set("n", "<leader>y", sync_file ,{ desc = "Sync file to remote Leaba", silent = true })
