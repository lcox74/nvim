return {
    name = "cssls",
    cmd = "vscode-css-language-server",
    config = {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss" },
        root_markers = { "package.json", ".git" },
    },
}
