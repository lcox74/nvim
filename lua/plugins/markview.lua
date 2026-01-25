local ok, markview = pcall(require, "markview")
if not ok then
    return
end

markview.setup({
    preview = {
        icon_provider = "devicons",
    },
})
