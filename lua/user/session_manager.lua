local M = {}
local selected_index = 1
local session_dir = vim.fn.stdpath("data") .. "/sessions/"

vim.fn.mkdir(session_dir, "p")

local function create_popup_window(content, title)
    local width = math.ceil(vim.o.columns * 0.3)
    local height = math.min(20, #content + 4)

    local row = math.ceil((vim.o.lines - height) / 2 - 1)
    local col = math.ceil((vim.o.columns - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
    vim.api.nvim_buf_set_option(buf, "filetype", "session_menu")

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = " " .. title .. " ",
        title_pos = "center",
    })

    -- Highlight the selected line
    selected_index = 1
    local ns_id = vim.api.nvim_create_namespace("session_menu")
    local function update_highlight()
        vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
        vim.api.nvim_buf_add_highlight(buf, ns_id, "Visual", selected_index - 1, 0, -1)
    end
    update_highlight()

    -- Move selection down
    local move_down = function()
        local line_count = vim.api.nvim_buf_line_count(buf)
        if selected_index < line_count then
            selected_index = selected_index + 1
        else
            selected_index = 1
        end

        local line = vim.api.nvim_get_current_line()
        local modified_line = " " .. line:gsub("^> ", "")
        vim.api.nvim_set_current_line(modified_line)

        vim.api.nvim_win_set_cursor(win, { selected_index, 0 })

        line = vim.api.nvim_get_current_line()
        modified_line = ">" .. string.sub(line, 1)
        vim.api.nvim_set_current_line(modified_line)
        update_highlight()

    end

    -- Move selection up
    local move_up = function()
        if selected_index > 1 then
            selected_index = selected_index - 1
        else
            selected_index = vim.api.nvim_buf_line_count(buf)
        end

        local line = vim.api.nvim_get_current_line()
        local modified_line = " " .. line:gsub("^> ", "")
        vim.api.nvim_set_current_line(modified_line)

        vim.api.nvim_win_set_cursor(win, { selected_index, 0 })

        line = vim.api.nvim_get_current_line()
        modified_line = ">" .. string.sub(line, 1)
        vim.api.nvim_set_current_line(modified_line)
        update_highlight()

    end

    vim.keymap.set('n', '<Up>', move_up, { buffer = buf, noremap = true, silent = true })
    vim.keymap.set('n', '<Down>', move_down, { buffer = buf, noremap = true, silent = true })
    vim.keymap.set('n', 'q', ":close<CR>", { buffer = buf, noremap = true, silent = true })
    vim.keymap.set('n', '<Esc>', ":close<CR>", { buffer = buf, noremap = true, silent = true })

    move_up()
    return buf, win
end

local function pad_strings(tbl, padding)
    local padded = {}
    local pad = string.rep(" ", padding)
    for _, str in ipairs(tbl) do
        table.insert(padded, pad .. str)
    end
    return padded
end

function M.show_session_manager()
    local sessions = vim.fn.globpath(session_dir, "*.vim", false, true)

    if #sessions == 0 then
        vim.notify("No sessions found", vim.log.levels.WARN)
        return
    end

    -- Extract only session names
    local session_names = vim.tbl_map(function(path)
        return vim.fn.fnamemodify(path, ":t:r")
    end, sessions)

    -- Display options in floating window
    local padded_sessions = pad_strings(session_names, 3)
    create_popup_window(padded_sessions, "Session Manager")
end

-- Save session
function M.save_session()
    local name = vim.fn.input("Session name: ")
    local session_file = session_dir .. name .. ".vim"
    vim.cmd("mksession! " .. session_file)
    vim.notify("Session saved as " .. name)
end

return M
