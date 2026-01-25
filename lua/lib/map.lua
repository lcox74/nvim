local M = {}


-- Registry of all keymaps for documentation
M.registry = {}


function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    if type(opts) == "string" then
        opts = { desc = opts }
    end
    opts.silent = opts.silent ~= false

    -- Track keymap source for documentation
    if opts.desc then
        local info = debug.getinfo(2, "S")
        local source = info.source:gsub("^@", "")
        local config_path = vim.fn.stdpath("config")
        source = source:gsub(config_path .. "/", "")

        table.insert(M.registry, {
            mode = type(mode) == "table" and table.concat(mode, ",") or mode,
            lhs = lhs,
            desc = opts.desc,
            source = source,
            buffer = opts.buffer ~= nil,
        })
    end

    vim.keymap.set(mode, lhs, rhs, opts)
end


-- Get keymaps grouped by source file
function M.get_grouped()
    local groups = {}
    for _, km in ipairs(M.registry) do
        local group = groups[km.source] or {}
        table.insert(group, km)
        groups[km.source] = group
    end
    return groups
end


return M
