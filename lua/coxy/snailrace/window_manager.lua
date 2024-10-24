local original_buf, original_win, original_win_config
local race_buf, race_win
local race_active = false

-- Dynamically resize the race window
local function resize_race_window()
    if vim.api.nvim_win_is_valid(race_win) then
        local new_width = vim.api.nvim_win_get_width(original_win)
        local new_height = vim.api.nvim_win_get_height(original_win)

        vim.api.nvim_win_set_config(race_win, {
            relative = 'editor',
            width = new_width,
            height = new_height,
            row = 0,
            col = 0,
        })
    end
end

-- Restore the original window and buffer after the race
local function restore_original_window()
    if vim.api.nvim_win_is_valid(race_win) then
        vim.api.nvim_win_close(race_win, true)
    end
    if vim.api.nvim_buf_is_valid(original_buf) and vim.api.nvim_win_is_valid(original_win) then
        vim.api.nvim_set_current_win(original_win)
        vim.api.nvim_set_current_buf(original_buf)
        vim.api.nvim_win_set_config(original_win, original_win_config)
    end
end

-- Create the snail race window
local function create_race_window()
    original_win = vim.api.nvim_get_current_win()
    original_buf = vim.api.nvim_get_current_buf()
    original_win_config = vim.api.nvim_win_get_config(original_win)

    race_buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
    race_win = vim.api.nvim_open_win(race_buf, true, {
        relative = 'editor',
        width = vim.api.nvim_win_get_width(original_win),
        height = vim.api.nvim_win_get_height(original_win),
        row = 0,
        col = 0,
        style = 'minimal',
        border = 'none',
    })

    -- Set the race as active
    race_active = true

    -- Autocommand to detect when the race window is closed
    vim.api.nvim_create_autocmd("BufWipeout", {
        buffer = race_buf,
        callback = function()
            race_active = false
            restore_original_window()
        end,
    })

    -- Autocommand to respond to window resizing
    -- TODO: This isn't working properly, but it isn't really a priority
    vim.api.nvim_create_autocmd("VimResized", {
        callback = resize_race_window,
    })
end

-- Check if the race is active
local function is_race_active()
    return race_active
end

return {
    create_race_window = create_race_window,
    restore_original_window = restore_original_window,
    is_race_active = is_race_active
}
