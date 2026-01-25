local M = {}


-- Registry of all autocmds for documentation
M.registry = {}


function M.autocmd(event, opts)
    opts = opts or {}

    -- Track autocmd for documentation
    if opts.desc then
        local group_name = nil
        if opts.group then
            -- If group is a string, use it directly
            -- If it's a number (augroup id), we can't easily get the name
            if type(opts.group) == "string" then
                group_name = opts.group
            end
        end

        local pattern = opts.pattern or "*"
        if type(pattern) == "table" then
            pattern = table.concat(pattern, ", ")
        end

        table.insert(M.registry, {
            event = type(event) == "table" and table.concat(event, ", ") or event,
            pattern = pattern,
            desc = opts.desc,
            group = group_name,
        })
    end

    return vim.api.nvim_create_autocmd(event, opts)
end


function M.augroup(name, opts)
    return vim.api.nvim_create_augroup(name, opts)
end


-- Get autocmds grouped by augroup name
function M.get_grouped()
    local groups = {}
    local ungrouped = {}

    for _, ac in ipairs(M.registry) do
        if ac.group then
            groups[ac.group] = groups[ac.group] or {}
            table.insert(groups[ac.group], ac)
        else
            table.insert(ungrouped, ac)
        end
    end

    if #ungrouped > 0 then
        groups["Other"] = ungrouped
    end

    return groups
end


return M
