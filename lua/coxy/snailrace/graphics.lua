local M = {}

-- Snail icon
M.snail_icon = "🐌"

-- Trophy icons based on placement
local trophy_icons = {
    [1] = "🥇", -- First place
    [2] = "🥈", -- Second place
    [3] = "🥉", -- Third place
}

M.get_trophy = function(place)
    if place <= 3 then
        return trophy_icons[place]
    end

    return ""
end

return M
