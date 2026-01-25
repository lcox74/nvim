return {
    name = "just_lsp",
    cmd = "just-lsp",
    config = {
        cmd = { "just-lsp" },
        filetypes = { "just" },
        root_markers = { "justfile", ".justfile", ".git" },
    },
}
