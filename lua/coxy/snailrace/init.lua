local race_logic = require("coxy.snailrace.race_logic")
local window_manager = require("coxy.snailrace.window_manager")

-- Function to start the snail race
local function start_race()
    window_manager.create_race_window() -- Create the new race window
    race_logic.reset_snails()           -- Reset the snails for a new race
    race_logic.start_race()             -- Start the race loop
end

-- Register the SnailRace command in Neovim
vim.api.nvim_create_user_command('SnailRace', start_race, {})
