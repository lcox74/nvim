if not vim.pack then
    return
end

-- Helper: get formatted package list
local function get_package_list()
    local packages = vim.pack.get()
    local list = {}
    for _, pkg in ipairs(packages) do
        table.insert(list, {
            name = pkg.spec.name,
            src = pkg.spec.src,
            path = pkg.path,
        })
    end
    table.sort(list, function(a, b) return a.name < b.name end)
    return list
end

-- :PackList
vim.api.nvim_create_user_command("PackList", function()
    local packages = get_package_list()
    for _, pkg in ipairs(packages) do
        print(string.format("%s (%s)", pkg.name, pkg.src))
    end
end, { desc = "List vim.pack packages" })

-- :PackPicker (Telescope)
vim.api.nvim_create_user_command("PackPicker", function()
    local ok, pickers = pcall(require, "telescope.pickers")
    local ok2, finders = pcall(require, "telescope.finders")
    local ok3, conf = pcall(require, "telescope.config")
    local ok4, actions = pcall(require, "telescope.actions")
    local ok5, action_state = pcall(require, "telescope.actions.state")

    if not (ok and ok2 and ok3 and ok4 and ok5) then
        vim.notify("Telescope not available", vim.log.levels.WARN)
        return
    end

    local packages = get_package_list()

    pickers.new({}, {
        prompt_title = "Packages",
        finder = finders.new_table({
            results = packages,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = string.format("%s (%s)", entry.name, entry.src),
                    ordinal = entry.name,
                }
            end,
        }),
        sorter = conf.values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local sel = action_state.get_selected_entry()
                if sel and sel.value.path then
                    vim.cmd.edit(sel.value.path)
                end
            end)
            return true
        end,
    }):find()
end, { desc = "Browse packages with Telescope" })

-- :PackStatus
vim.api.nvim_create_user_command("PackStatus", function()
    local packages = get_package_list()
    vim.notify(string.format("Packages: %d installed", #packages))
end, { desc = "Show package status summary" })

-- :PackUpdate
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.notify("Updating packages...")
    vim.pack.update()
end, { desc = "Update all packages" })

-- Helper: check if git remote exists
local function git_remote_exists(url, callback)
    vim.system({ "git", "ls-remote", url }, {}, function(result)
        vim.schedule(function()
            callback(result.code == 0)
        end)
    end)
end

-- :PackAdd <url>
vim.api.nvim_create_user_command("PackAdd", function(opts)
    local url = opts.args
    if url == "" then
        vim.notify("Usage: :PackAdd <url>", vim.log.levels.ERROR)
        return
    end

    if not url:match("^https?://") then
        vim.notify("Invalid URL: must start with http:// or https://", vim.log.levels.ERROR)
        return
    end

    vim.notify("Checking if repository exists...")
    git_remote_exists(url, function(exists)
        if not exists then
            vim.notify("Repository not found: " .. url, vim.log.levels.ERROR)
            return
        end
        vim.notify("Adding package: " .. url)
        vim.pack.add({ { src = url } })
    end)
end, { nargs = 1, desc = "Add a package by URL" })

-- Helper: check if package is installed
local function get_installed_package(name)
    for _, pkg in ipairs(vim.pack.get()) do
        if pkg.spec.name == name then
            return pkg
        end
    end
    return nil
end

-- :PackDel <name>
vim.api.nvim_create_user_command("PackDel", function(opts)
    -- Parse name from "name (url)" format if selected from completion
    local name = opts.args:match("^(%S+)") or opts.args
    if name == "" then
        vim.notify("Usage: :PackDel <name>", vim.log.levels.ERROR)
        return
    end

    local pkg = get_installed_package(name)
    if not pkg then
        vim.notify("Package not installed: " .. name, vim.log.levels.ERROR)
        return
    end

    local src = pkg.spec and pkg.spec.src or "unknown source"
    vim.ui.select({ "Yes", "No" }, {
        prompt = "Delete '" .. name .. "' (" .. src .. ")?",
    }, function(choice)
        if choice == "Yes" then
            vim.pack.del({ name })
            vim.notify("Deleted: " .. name)
        end
    end)
end, {
    nargs = "+",
    desc = "Delete a package by name",
    complete = function()
        local items = {}
        for _, pkg in ipairs(vim.pack.get()) do
            local src = pkg.spec and pkg.spec.src or ""
            table.insert(items, pkg.spec.name .. " (" .. src .. ")")
        end
        return items
    end,
})

-- Keymap
vim.keymap.set("n", "<leader>fp", "<cmd>PackPicker<cr>", { desc = "Find packages" })
