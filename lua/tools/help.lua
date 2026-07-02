local M = {}

-- vimdoc constants
local MAX_WIDTH = 78
local INDENT = "  " -- 2 spaces (vimdoc standard)

-- Source file to friendly group name mapping for keymaps
local keymap_group_names = {
    ["lua/core/keymaps.lua"] = "Core",
    ["lua/plugins/barbar.lua"] = "Buffers",
    ["lua/plugins/neotree.lua"] = "File Tree",
    ["lua/lsp/init.lua"] = "LSP",
    ["lua/plugins/telescope.lua"] = "Telescope",
    ["lua/plugins/gitsigns.lua"] = "Git Signs",
    ["lua/plugins/pack.lua"] = "Package Manager",
    ["lua/tools/update.lua"] = "Updates",
}

-- Order for keymap groups (unlisted appear at end)
local keymap_group_order = {
    "lua/core/keymaps.lua",
    "lua/plugins/barbar.lua",
    "lua/plugins/neotree.lua",
    "lua/lsp/init.lua",
    "lua/plugins/telescope.lua",
    "lua/plugins/gitsigns.lua",
    "lua/plugins/pack.lua",
    "lua/tools/update.lua",
}


-- Load a template file from doc/templates/
local function load_template(name)
    local config_path = vim.fn.stdpath("config")
    local path = config_path .. "/doc/templates/" .. name
    local file = io.open(path, "r")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    return content
end


-- Convert name to slug: "Git Signs" -> "git-signs"
local function to_slug(name)
    return name:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")
end


-- Format a header line with name~ on left and *tag* right-aligned at column 78
local function format_header(name, tag_name)
    local left = name .. "~"
    local right = "*" .. tag_name .. "*"
    local padding = MAX_WIDTH - #left - #right
    if padding > 0 then
        return left .. string.rep(" ", padding) .. right
    end
    return left .. " " .. right
end


-- Wrap description to multiple lines if too long
-- Returns a table of lines (first line is the description start, rest are continuations)
local function wrap_desc(desc, max_width, continuation_indent)
    if #desc <= max_width then
        return { desc }
    end

    local lines = {}
    local remaining = desc

    while #remaining > 0 do
        local width = #lines == 0 and max_width or (MAX_WIDTH - continuation_indent)

        if #remaining <= width then
            table.insert(lines, remaining)
            break
        end

        -- Find last space within width
        local break_at = width
        for i = width, 1, -1 do
            if remaining:sub(i, i) == " " then
                break_at = i
                break
            end
        end

        -- If no space found, force break at width
        if break_at == width and remaining:sub(width, width) ~= " " then
            break_at = width
        end

        table.insert(lines, (remaining:sub(1, break_at):gsub("%s+$", "")))
        remaining = (remaining:sub(break_at + 1):gsub("^%s+", ""))
    end

    return lines
end


-- Format a keymap entry for help doc
-- Format: "  %-18s  %-4s  %s" (2 + 18 + 2 + 4 + 2 + desc = 28 + desc)
-- Returns a table of lines (for wrapping support)
local KEYMAP_DESC_INDENT = 28 -- column where description starts

local function format_keymap(km)
    local mode = km.mode

    local desc = km.desc
    if km.buffer then
        desc = desc .. " [buf]"
    end

    local lhs = km.lhs:gsub("<", "<"):gsub(">", ">")

    -- Max description width: 78 - 28 = 50 chars
    local desc_lines = wrap_desc(desc, 50, KEYMAP_DESC_INDENT)

    local result = {}
    for i, line in ipairs(desc_lines) do
        if i == 1 then
            table.insert(result, string.format("%s%-18s  %-4s  %s", INDENT, lhs, mode, line))
        else
            table.insert(result, string.rep(" ", KEYMAP_DESC_INDENT) .. line)
        end
    end

    return result
end


-- Generate the keymaps section content
function M.generate_keymaps_section()
    local map = require("lib.map")
    local groups = map.get_grouped()
    local lines = {}

    -- Load template (fallback to inline if missing)
    local template = load_template("keymap-group.template")

    -- Process groups in order
    local seen = {}
    local ordered_sources = {}

    for _, source in ipairs(keymap_group_order) do
        if groups[source] then
            table.insert(ordered_sources, source)
            seen[source] = true
        end
    end

    -- Add any remaining groups
    for source in pairs(groups) do
        if not seen[source] then
            table.insert(ordered_sources, source)
        end
    end

    for _, source in ipairs(ordered_sources) do
        local keymaps = groups[source]
        local name = keymap_group_names[source] or source
        local slug = to_slug(name)
        local tag_name = "wort-keymaps-" .. slug

        local header_line = format_header(name, tag_name)
        local entry_lines = {}
        for _, km in ipairs(keymaps) do
            local km_lines = format_keymap(km)
            for _, line in ipairs(km_lines) do
                table.insert(entry_lines, line)
            end
        end
        local entries = table.concat(entry_lines, "\n")

        if template then
            -- Use template
            local section = template
            section = section:gsub("{{HEADER}}", header_line)
            section = section:gsub("{{ENTRIES}}", entries)
            table.insert(lines, section)
        else
            -- Fallback inline generation
            table.insert(lines, header_line)
            table.insert(lines, "")
            table.insert(lines, INDENT .. "Key                  Mode  Description")
            table.insert(lines, INDENT .. string.rep("-", 74))

            for _, line in ipairs(entry_lines) do
                table.insert(lines, line)
            end
            table.insert(lines, "")
        end
    end

    return table.concat(lines, "\n")
end

-- Format an autocmd entry for help doc
-- Format: "  %-22s  %s" (2 + 22 + 2 + desc = 26 + desc)
-- Returns a table of lines (for wrapping support)
local AUTOCMD_DESC_INDENT = 26 -- column where description starts

local function format_autocmd(event, desc)
    -- Max description width: 78 - 26 = 52 chars
    local desc_lines = wrap_desc(desc, 52, AUTOCMD_DESC_INDENT)

    local result = {}
    for i, line in ipairs(desc_lines) do
        if i == 1 then
            table.insert(result, string.format("%s%-22s  %s", INDENT, event, line))
        else
            table.insert(result, string.rep(" ", AUTOCMD_DESC_INDENT) .. line)
        end
    end

    return result
end


-- Generate the autocmds section content
function M.generate_autocmds_section()
    local ac = require("lib.autocmd")
    local groups = ac.get_grouped()
    local lines = {}

    -- Load template (fallback to inline if missing)
    local template = load_template("autocmd-group.template")

    -- Sort group names, but put "Other" last
    local group_names = {}
    for name in pairs(groups) do
        if name ~= "Other" then
            table.insert(group_names, name)
        end
    end
    table.sort(group_names)
    if groups["Other"] then
        table.insert(group_names, "Other")
    end

    for _, group_name in ipairs(group_names) do
        local autocmds = groups[group_name]
        local slug = to_slug(group_name)
        local tag_name = "wort-autocmds-" .. slug

        -- Sort autocmds by event within group
        table.sort(autocmds, function(a, b)
            if a.event == b.event then
                return a.desc < b.desc
            end
            return a.event < b.event
        end)

        local entry_lines = {}
        for _, cmd in ipairs(autocmds) do
            local pattern = cmd.pattern or "*"
            -- Escape asterisks to prevent them being interpreted as help tags
            pattern = pattern:gsub("%*", "{*}")

            local desc = cmd.desc
            if pattern ~= "{*}" then
                desc = desc .. " [" .. pattern .. "]"
            end

            -- Handle multiple events (comma-separated)
            local events = {}
            for event in cmd.event:gmatch("[^,]+") do
                table.insert(events, vim.trim(event))
            end

            if #events > 1 then
                -- First event gets the description
                local ac_lines = format_autocmd(events[1], desc)
                for _, line in ipairs(ac_lines) do
                    table.insert(entry_lines, line)
                end
                -- Remaining events with vertical bar
                for i = 2, #events do
                    table.insert(entry_lines, INDENT .. "| " .. events[i])
                end
            else
                local ac_lines = format_autocmd(cmd.event, desc)
                for _, line in ipairs(ac_lines) do
                    table.insert(entry_lines, line)
                end
            end
        end

        local header_line = format_header(group_name, tag_name)
        local entries = table.concat(entry_lines, "\n")

        if template then
            -- Use template
            local section = template
            section = section:gsub("{{HEADER}}", header_line)
            section = section:gsub("{{ENTRIES}}", entries)
            table.insert(lines, section)
        else
            -- Fallback inline generation
            table.insert(lines, header_line)

            for _, line in ipairs(entry_lines) do
                table.insert(lines, line)
            end
            table.insert(lines, "")
        end
    end

    return table.concat(lines, "\n")
end

-- Generate and write the help file
-- opts.silent: don't notify unless file changed
-- opts.force: write even if content matches
function M.generate(opts)
    opts = opts or {}
    local config_path = vim.fn.stdpath("config")
    local template_path = config_path .. "/doc/wort.template"
    local output_path = config_path .. "/doc/wort.txt"

    -- Read template
    local file = io.open(template_path, "r")
    if not file then
        if not opts.silent then
            vim.notify("Help template not found: " .. template_path, vim.log.levels.ERROR)
        end
        return
    end
    local content = file:read("*a")
    file:close()

    -- Generate sections
    local keymaps_content = M.generate_keymaps_section()
    local autocmds_content = M.generate_autocmds_section()

    -- Replace placeholders
    content = content:gsub("{{KEYMAPS}}", keymaps_content)
    content = content:gsub("{{AUTOCMDS}}", autocmds_content)

    -- Check if file exists and content matches
    if not opts.force then
        local existing = io.open(output_path, "r")
        if existing then
            local existing_content = existing:read("*a")
            existing:close()
            if existing_content == content then
                -- No changes needed
                return false
            end
        end
    end

    -- Write output
    file = io.open(output_path, "w")
    if not file then
        if not opts.silent then
            vim.notify("Cannot write help file", vim.log.levels.ERROR)
        end
        return
    end
    file:write(content)
    file:close()

    -- Regenerate help tags
    vim.cmd("helptags " .. config_path .. "/doc")

    if not opts.silent then
        local keymap_count = #require("lib.map").registry
        vim.notify("Generated help doc with " .. keymap_count .. " keymaps")
    end

    return true
end

-- Auto-generate on startup (deferred until idle)
vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        -- Defer until Neovim is idle (won't block startup)
        vim.defer_fn(function()
            M.generate({ silent = true })
        end, 500)
    end,
    once = true,
})


return M
