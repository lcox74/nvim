local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
    return
end

catppuccin.setup({
    flavour = "mocha",
    integrations = {
        telescope = {
            enabled = true,
        }
    },
})

catppuccin.load()