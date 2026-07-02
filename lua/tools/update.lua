local M = {}

local map = require("lib.map").map


-- Update mason packages: refresh the registry, reinstall anything outdated
local function update_mason()
    local ok, registry = pcall(require, "mason-registry")
    if not ok then
        return
    end

    registry.update(function(success)
        vim.schedule(function()
            if not success then
                vim.notify("Mason: registry update failed", vim.log.levels.WARN)
                return
            end

            local outdated = 0
            for _, pkg in ipairs(registry.get_installed_packages()) do
                local current = pkg:get_installed_version()
                local latest = pkg:get_latest_version()
                if current ~= latest then
                    outdated = outdated + 1
                    vim.notify(string.format("Mason: updating %s (%s -> %s)", pkg.name, current, latest))
                    pkg:install()
                end
            end

            if outdated == 0 then
                vim.notify("Mason: all packages up to date")
            end
        end)
    end)
end


-- Update installed treesitter parsers
local function update_treesitter()
    local ok, ts = pcall(require, "nvim-treesitter")
    if ok and vim.fn.executable("tree-sitter") == 1 then
        ts.update()
    end
end


-- Update everything: plugins, mason packages, treesitter parsers
function M.update_all()
    -- Opens the review buffer (:w applies, :q aborts); mason and treesitter
    -- update in the background meanwhile
    vim.pack.update()

    update_mason()
    update_treesitter()
end


vim.api.nvim_create_user_command("UpdateAll", M.update_all, {
    desc = "Update plugins, mason packages, and treesitter parsers",
})

map("n", "<leader>cu", "<cmd>UpdateAll<cr>", "Update everything")


return M
