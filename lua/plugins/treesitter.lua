local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

configs.setup({
    ensure_installed = {
        "go",
        "lua",

        -- Web
        "javascript",
        "typescript",
        "html",
        "css",

        "bash",
        "json",
        "yaml",
        "markdown",
    },

    auto_install = false, -- Run :TSUpdate manually after adding new parsers

    highlight = { enable = true },
    indent = { enable = true },
})
