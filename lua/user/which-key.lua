require("which-key").setup{
    win = {
        no_overlap = true,
        height = { min = 4, max = 25 },
        padding = { 1, 2 }, -- [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = {
        },
    },
    triggers = {
        "<leader>",
    },
}
