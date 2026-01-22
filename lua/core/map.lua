local M = {}

function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    if type(opts) == "string" then
        opts = { desc = opts }
    end
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
