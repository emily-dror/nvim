local ts_utils = require('nvim-treesitter.ts_utils')

local tex_mappings = {
    ["("] = {
        ["default"] = { rhs = "\\(  \\)", cursor_pos = 3 },
        ["math_delimiter"] = { rhs = "\\left(", cursor_pos = 0 },
        ["inline_formula"] = { rhs = "\\left(  \\right)", cursor_pos = 8 },
        ["displayed_equation"] = { rhs = "\\left(  \\right)", cursor_pos = 8 },
    },
    [")"] = { ["math_delimiter"] = { rhs = "\\right)", cursor_pos = 0 } },
    ["{"] = {
        ["default"] = { rhs = "{  }", cursor_pos = 2 },
        ["math_delimiter"] = { rhs = "\\left\\{", cursor_pos = 0 },
        ["inline_formula"] = { rhs = "\\left\\{  \\right\\}", cursor_pos = 9 },
        ["displayed_equation"] = { rhs = "\\left\\{  \\right\\}", cursor_pos = 9 },
    },
    ["}"] = { ["math_delimiter"] = { rhs = "\\right\\}", cursor_pos = 0 } },
    ["["] = {
        ["default"] = { rhs = "\\[  \\]", cursor_pos = 3 },
        ["math_delimiter"] = { rhs = "\\left[", cursor_pos = 0 },
        ["inline_formula"] = { rhs = "\\left[  \\right]", cursor_pos = 8 },
        ["displayed_equation"] = { rhs = "\\left[  \\right]", cursor_pos = 8 },
    },
    ["]"] = { ["math_delimiter"] = { rhs = "\\right]", cursor_pos = 0 } },
    ["|"] = {
        ["inline_formula"] = { rhs = "\\left| \\right|", cursor_pos = 8 },
        ["displayed_equation"] = { rhs = "\\left| \\right|", cursor_pos = 8 },
    },
    ["||"] = {
        ["inline_formula"] = { rhs = "\\left\\|  \\right\\|", cursor_pos = 9 },
        ["displayed_equation"] = { rhs = "\\left\\|  \\right\\|", cursor_pos = 9 },
    },
    ["<"] = {
        ["math_delimiter"] = { rhs = "\\langle", cursor_pos = 0 },
        ["inline_formula"] = { rhs = "\\langle  \\rangle", cursor_pos = 8 },
        ["displayed_equation"] = { rhs = "\\langle  \\rangle", cursor_pos = 8 },
    },
    [">"] = { ["math_delimiter"] = { rhs = "\\rangle", cursor_pos = 0 } },

    -- Math symbols
    ["0"] = {
        ["inline_formula"] = { rhs = "\\emptyset", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\emptyset", cursor_pos = 0 },
    },
    ["2"] = {
        ["inline_formula"] = { rhs = "\\sqrt", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\sqrt", cursor_pos = 0 },
    },
    ["6"] = {
        ["inline_formula"] = { rhs = "\\partial", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\partial", cursor_pos = 0 },
    },
    ["8"] = {
        ["inline_formula"] = { rhs = "\\infty", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\infty", cursor_pos = 0 },
    },
    ["="] = {
        ["inline_formula"] = { rhs = "\\equiv", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\equiv", cursor_pos = 0 },
    },
    ["\\"] = {
        ["inline_formula"] = { rhs = "\\setminus", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\setminus", cursor_pos = 0 },
    },
    ["."] = {
        ["inline_formula"] = { rhs = "\\cdot", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\cdot", cursor_pos = 0 },
    },
    ["*"] = {
        ["inline_formula"] = { rhs = "\\times", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\times", cursor_pos = 0 },
    },
    ["H"] = {
        ["inline_formula"] = { rhs = "\\hbar", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\hbar", cursor_pos = 0 },
    },
    ["+"] = {
        ["inline_formula"] = { rhs = "\\dagger", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\dagger", cursor_pos = 0 },
    },
    ["A"] = {
        ["inline_formula"] = { rhs = "\\forall", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\forall", cursor_pos = 0 },
    },
    ["B"] = { ["default"] = { rhs = "\\textbf{}", cursor_pos = 1 } },
    ["I"] = { ["default"] = { rhs = "\\textit{}", cursor_pos = 1 } },
    ["U"] = { ["default"] = { rhs = "\\underline{}", cursor_pos = 1 } },
    ["E"] = {
        ["inline_formula"] = { rhs = "\\exists", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\exists", cursor_pos = 0 },
    },
    ["L"] = {
        ["inline_formula"] = { rhs = "\\bigg", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\bigg", cursor_pos = 0 },
    },
    ["T"] = {
        ["inline_formula"] = { rhs = "\\text{}", cursor_pos = 1 },
        ["displayed_equation"] = { rhs = "\\text{}", cursor_pos = 1 },
    },
    ["M"] = {
        ["default"] = { rhs = "\\[  \\]", cursor_pos = 3 },
        ["inline_formula"] = { rhs = "\\mathcal{}", cursor_pos = 1 },
        ["displayed_equation"] = { rhs = "\\mathcal{}", cursor_pos = 1 },
    },
    ["N"] = {
        ["inline_formula"] = { rhs = "\\nabla", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\nabla", cursor_pos = 0 },
    },
    ["jj"] = {
        ["inline_formula"] = { rhs = "\\downarrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\downarrow", cursor_pos = 0 },
    },
    ["jJ"] = {
        ["inline_formula"] = { rhs = "\\Downarrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\Downarrow", cursor_pos = 0 },
    },
    ["jk"] = {
        ["inline_formula"] = { rhs = "\\uparrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\uparrow", cursor_pos = 0 },
    },
    ["jK"] = {
        ["inline_formula"] = { rhs = "\\Uparrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\Uparrow", cursor_pos = 0 },
    },
    ["jh"] = {
        ["inline_formula"] = { rhs = "\\leftarrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\leftarrow", cursor_pos = 0 },
    },
    ["jH"] = {
        ["inline_formula"] = { rhs = "\\Leftarrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\Leftarrow", cursor_pos = 0 },
    },
    ["jl"] = {
        ["inline_formula"] = { rhs = "\\rightarrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\rightarrow", cursor_pos = 0 },
    },
    ["jL"] = {
        ["inline_formula"] = { rhs = "\\Rightarrow", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\Rightarrow", cursor_pos = 0 },
    },
    ["a"] = {
        ["inline_formula"] = { rhs = "\\alpha", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\alpha", cursor_pos = 0 },
    },
    ["b"] = {
        ["inline_formula"] = { rhs = "\\beta", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\beta", cursor_pos = 0 },
    },
    ["c"] = {
        ["inline_formula"] = { rhs = "\\chi", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\chi", cursor_pos = 0 },
    },
    ["d"] = {
        ["inline_formula"] = { rhs = "\\delta", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\delta", cursor_pos = 0 },
    },
    ["e"] = {
        ["inline_formula"] = { rhs = "\\epsilon", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\epsilon", cursor_pos = 0 },
    },
    ["f"] = {
        ["inline_formula"] = { rhs = "\\phi", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\phi", cursor_pos = 0 },
    },
    ["g"] = {
        ["inline_formula"] = { rhs = "\\gamma", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\gamma", cursor_pos = 0 },
    },
    ["h"] = {
        ["inline_formula"] = { rhs = "\\eta", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\eta", cursor_pos = 0 },
    },
    ["i"] = {
        ["inline_formula"] = { rhs = "\\iota", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\iota", cursor_pos = 0 },
    },
    ["k"] = {
        ["inline_formula"] = { rhs = "\\kappa", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\kappa", cursor_pos = 0 },
    },
    ["l"] = {
        ["inline_formula"] = { rhs = "\\lambda", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\lambda", cursor_pos = 0 },
    },
    ["m"] = {
        ["default"] = { rhs = "\\(  \\)", cursor_pos = 3 },
        ["inline_formula"] = { rhs = "\\mu", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\mu", cursor_pos = 0 },
    },
    ["n"] = {
        ["inline_formula"] = { rhs = "\\nu", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\nu", cursor_pos = 0 },
    },
    ["p"] = {
        ["inline_formula"] = { rhs = "\\pi", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\pi", cursor_pos = 0 },
    },
    ["q"] = {
        ["inline_formula"] = { rhs = "\\theta", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\theta", cursor_pos = 0 },
    },
    ["r"] = {
        ["inline_formula"] = { rhs = "\\rho", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\rho", cursor_pos = 0 },
    },
    ["s"] = {
        ["inline_formula"] = { rhs = "\\sigma", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\sigma", cursor_pos = 0 },
    },
    ["t"] = {
        ["inline_formula"] = { rhs = "\\tau", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\tau", cursor_pos = 0 },
    },
    ["y"] = {
        ["inline_formula"] = { rhs = "\\psi", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\psi", cursor_pos = 0 },
    },
    ["u"] = {
        ["inline_formula"] = { rhs = "\\upsilon", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\upsilon", cursor_pos = 0 },
    },
    ["w"] = {
        ["inline_formula"] = { rhs = "\\omega", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\omega", cursor_pos = 0 },
    },
    ["z"] = {
        ["inline_formula"] = { rhs = "\\zeta", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\zeta", cursor_pos = 0 },
    },
    ["x"] = {
        ["inline_formula"] = { rhs = "\\xi", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\xi", cursor_pos = 0 },
    },

    -- Variants mappings
    ["ve"] = {
        ["inline_formula"] = { rhs = "\\varepsilon", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\varepsilon", cursor_pos = 0 },
    },
    ["vf"] = {
        ["inline_formula"] = { rhs = "\\varphi", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\varphi", cursor_pos = 0 },
    },
    ["vk"] = {
        ["inline_formula"] = { rhs = "\\varkappa", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\varkappa", cursor_pos = 0 },
    },
    ["vp"] = {
        ["inline_formula"] = { rhs = "\\varpi", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\varpi", cursor_pos = 0 },
    },
    ["vq"] = {
        ["inline_formula"] = { rhs = "\\vartheta", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\vartheta", cursor_pos = 0 },
    },
    ["vr"] = {
        ["inline_formula"] = { rhs = "\\varrho", cursor_pos = 0 },
        ["displayed_equation"] = { rhs = "\\varrho", cursor_pos = 0 },
    },
}

local function mv_cur(str, l)
    return str .. string.rep("<Left>", l)
end

local function find(table, element)
    for key, value in pairs(table) do
        if key == element then
            return value
        end
    end
    return nil
end

local function insert_scoped(map)
    local node = ts_utils.get_node_at_cursor()
    while node do
        -- look for the node's type in the mapping spec
        local keymap = find(map, node:type())
        if keymap then
            return mv_cur(keymap.rhs, keymap.cursor_pos)
        end
        node = node:parent()
    end
    -- node's type isn't present, return default if present
    if map["default"] then
        return mv_cur(map["default"].rhs, map["default"].cursor_pos)
    end
    return nil
end

local function set_mappings(maps, leader)
    for key, map in pairs(maps) do
        vim.keymap.set("i", leader .. key, function()
            return insert_scoped(map) or leader .. key
        end, { expr = true, noremap = true, buffer = 0 })
    end
    vim.keymap.set("n", "<leader>pc", function()
        print(ts_utils.get_node_at_cursor():type())
    end, { expr = true, noremap = true })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex", callback = function() set_mappings(tex_mappings, ";") end
})



