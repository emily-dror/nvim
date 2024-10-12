local M = {}

-- Easter Egg
M.emily = function()
    print("Appa, yip yip!!")
end


-- Relative Numbering
M.relative_numbering = function()
    vim.cmd("set relativenumber!")
end


-- Show alpha screen
M.toggle_alpha = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if string.find(buf_name, "Alpha") then
        vim.cmd("bdelete!")
    else
        vim.cmd("Alpha")
    end
end


-- Buffer Navigation
M.bnext = function()
    vim.cmd("bnext")
end

M.bprevious = function()
    vim.cmd("bprevious")
end

M.bclose = function()
    local current_buf = vim.api.nvim_get_current_buf()
    vim.cmd("bnext")
    vim.api.nvim_buf_delete(current_buf, { force = false })
end


-- File Operations
M.copy_filename = function()
    -- "+" is the register for the system clipboard
    local file_name = vim.fn.expand("%"):match "([^/\\]+)[/\\]*$"
    vim.fn.setreg("+", file_name)
    print("Copied relative path to clipboard: " .. file_name)
end

M.copy_full_path = function()
    -- "+" is the register for the system clipboard
    local file_name = vim.fn.expand("%:p")
    vim.fn.setreg("+", file_name)
    print("Copied full path to clipboard: " .. file_name)
end

M.copy_relative_path = function()
    -- "+" is the register for the system clipboard
    local file_name = vim.fn.expand("%")
    vim.fn.setreg("+", file_name)
    print("Copied relative path to clipboard: " .. file_name)
end


-- Git diff
M.git_diff = function()
  local file_path = vim.fn.expand("%")
  local buf = vim.api.nvim_create_buf(false, true)

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    row = math.floor((vim.o.lines -  math.floor(vim.o.lines * 0.8)) / 2),
    col = math.floor((vim.o.columns -  math.floor(vim.o.columns * 0.8)) / 2),
    style = "minimal",
    border = "rounded",
  })

  -- Run the Git command asynchronously and capture the output
  local cmd = string.format("git diff HEAD^ -- %s", file_path)
  local output = vim.fn.systemlist(cmd)

  -- Set the output to the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'diff')
end

-- Git blame current line
M.git_blame = function()
    local file_path = vim.fn.expand("%")
    local line_number = vim.fn.line(".")

    local cmd = string.format("git --no-pager blame -L %d,+1 -- %s 2> /dev/null", line_number, file_path)
    local handle = io.popen(cmd)
    if handle == nil then
        print("Failed to run git blame command.")
        return
    end

    local hash, author, date = handle:read("*a"):match("(%x+) %((.-) (%d+%-%d+%-%d+)")
    handle:close()

    local cmd = string.format("git --no-pager log -n 1 --pretty=format:%%s %s 2> /dev/null", hash)
    local handle = io.popen(cmd)
    if handle == nil then
        print("Failed to run git blame command.")
        return
    end

    local title = handle:read("*a")
    handle:close()

    local msg = string.format("%s (%s %s) ... copy hash to clipboard? [y/N]", title, author, date)
    local input = vim.fn.input(msg)

    if input == "y" then
        vim.fn.setreg("+", hash)
        print("Hash copied to clipboard!")
    end
end


M.git_branch = function()
    local handle = io.popen("git symbolic-ref --short -q HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null")
    local result = handle:read("*a")
    handle:close()

    -- Trim any trailing whitespace or newlines
    result = result:gsub("%s+", "")

    if string.match(result, "^%a") then
        -- It's a branch name (starts with a letter)
        return result
    end

    if string.match(result, "^%x+") then
        -- It's a commit hash (starts with a hexadecimal character)
        return result
    end

    return nil
end

-- Highlight and trim whitespaces

M.match_id = nil
M.highlight_enabled = true

M.toggle_ws = function()
    M.highlight_enabled = not M.highlight_enabled
    if M.highlight_enabled then
        if M.match_id ~= nil then
            vim.fn.matchdelete(M.match_id)
            M.match_id = nil
        end
    else
        M.match_id = vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
    end
end


M.remove_wl = function()
    vim.cmd([[%s/\(\n\)\+$/\r/]])
    vim.cmd("noh")
    vim.cmd("w")
end

return M
