local M = {}

function M.dir(module_prefix, callback)
    local path = vim.fn.stdpath("config") .. "/lua/" .. module_prefix:gsub("%.", "/")
    for _, file in ipairs(vim.fn.glob(path .. "/*.lua", false, true)) do
        local name = module_prefix .. "." .. vim.fn.fnamemodify(file, ":t:r")
        local mod = require(name)
        if callback then
            callback(mod)
        end
    end
end

return M
