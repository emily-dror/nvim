require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.statusline"
require "user.alpha"
require "user.nvim-tree"
require "user.templates"
require "user.nvim-window"
require "user.session_manager"
require "user.latex"

-- local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
--
-- -- Define a snippet for LaTeX math environment
-- ls.add_snippets("tex", {
--     s("(", {
--         t("\\("), i(1), t("\\)"),
--     }),
--     s("eq", {
--         t("\\begin{equation}"), i(1), t("\\end{equation}"),
--     }),
-- })
--
