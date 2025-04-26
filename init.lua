require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.treesitter"
require "user.nvim-tree"
require "user.templates"
require "user.nvim-window"
require "user.coc"
require "user.session_manager"
require "user.leaba"

local status_ok, bufferline = pcall(require, "bufferline")
 if not status_ok then
     return
 end

 bufferline.setup {
     options = {
         close_command = "bdelete! %d",
         right_mouse_command = "bdelete! %d",
         left_mouse_command = "buffer %d",
         middle_mouse_command = nil,
         buffer_close_icon = '',
         modified_icon = "●",
         close_icon = "",
         left_trunc_marker = "",
         right_trunc_marker = "",
         max_name_length = 18,
         max_prefix_length = 15,
         tab_size = 20,
         diagnostics = false,
         diagnostics_update_in_insert = false,
         offsets = {{ filetype = "NvimTree", text = "EXPLORER", text_align = "center" }},
         show_buffer_icons = true,
         show_buffer_close_icons = true,
         show_close_icon = true,
         show_tab_indicators = true,
         persist_buffer_sort = true,
         separator_style = "slant",
         enforce_regular_tabs = true,
         always_show_bufferline = true,
     },
 }
