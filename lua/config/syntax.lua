-- Enable syntax highlighting
vim.cmd("syntax on")

-- Enable file detection for dot environment files and set filetype to env
-- to auto load the env.vim syntax file from nvim/syntax
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.env", "*.env.*" },
    callback = function()
        vim.bo.filetype = "env"
    end,
})
