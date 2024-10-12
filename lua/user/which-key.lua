require("which-key").setup{
    win = {
        -- don't allow the popup to overlap with the cursor
        no_overlap = true,
        -- width = 1,
        height = { min = 4, max = 25 },
        -- col = 0,
        -- row = math.huge,
        -- border = "none",
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
          -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
    },
    triggers = {
        -- Don't automatically show which-key popup for the leader key
        "<leader>", -- remove this from the automatic triggers
    },
}
