local utils = require("coxy.snailrace.utils")
local window_manager = require("coxy.snailrace.window_manager")
local graphics = require("coxy.snailrace.graphics")

local snails = {}
local finish_order = {}
local race_buf
local placement = 1

-- Initialise snails for the race
local function reset_snails()
    for i = 1, 8 do
        snails[i] = { pos = 0, track_num = i, finished = false }
    end
    finish_order = {}
    placement = 1
end

-- Render the race track in the buffer
local function render_track()
    if not window_manager.is_race_active() then return end

    local lines = {}
    local race_length = 40
    local race_win_width = vim.api.nvim_win_get_width(0)
    local race_win_height = vim.api.nvim_win_get_height(0)
    local track_height = 10

    -- Calculate horizontal and vertical padding for centering
    local left_padding = math.max(math.floor((race_win_width - race_length - 10) / 2), 0)
    local top_padding = math.max(math.floor((race_win_height - track_height) / 2), 0)

    -- Clear the buffer before rendering
    vim.api.nvim_buf_set_lines(race_buf, 0, -1, false, {})

    -- Add top padding
    for _ = 1, top_padding do
        table.insert(lines, "")
    end

    -- Add race track lines with padding
    local padding = string.rep(" ", left_padding)
    table.insert(lines, padding .. "   " .. string.rep(" ", race_length + 2) .. "🏁")
    table.insert(lines, padding .. "  |" .. string.rep("-", race_length + 2) .. "|")

    for _, snail in ipairs(snails) do
        local track = string.rep(".", snail.pos - 1) .. graphics.snail_icon .. string.rep(" ", race_length - snail.pos) .. "|"
        if snail.finished then
            local place = finish_order[snail.track_num]
            track = string.rep(".", race_length) .. graphics.snail_icon .. tostring(place) .. graphics.get_trophy(place)
        end
        table.insert(lines, padding .. string.format("%2d| %s", snail.track_num, track))
    end

    table.insert(lines, padding .. "  |" .. string.rep("-", race_length + 2) .. "|")

    -- Update the buffer with the race track
    vim.api.nvim_buf_set_lines(race_buf, 0, -1, false, lines)
end

-- Simulate the race step-by-step
local function race_step()
    if not window_manager.is_race_active() then return end

    local total_finished = 0
    for _, snail in ipairs(snails) do
        if snail.finished then
            total_finished = total_finished + 1
        end
    end

    if total_finished < #snails then
        for _, snail in ipairs(snails) do
            if not snail.finished then
                snail.pos = snail.pos + math.random(0, 2)
                if snail.pos >= 40 then
                    snail.pos = 40
                    snail.finished = true
                    finish_order[snail.track_num] = placement
                    placement = placement + 1
                end
            end
        end

        render_track()
        vim.defer_fn(race_step, 500)
    else
        -- Restart the race after a delay
        local delay = math.random(5000, 10000)
        vim.defer_fn(function()
            if not window_manager.is_race_active() then return end

            reset_snails()
            race_step()
        end, delay)
    end
end

-- Function to start the race
local function start_race()
    race_buf = vim.api.nvim_get_current_buf()
    utils.set_buffer_scratch(race_buf)
    race_step()
end

return {
    reset_snails = reset_snails,
    start_race = start_race
}
