return {
    name = "bashls",
    cmd = "bash-language-server",
    config = {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
    },
}
