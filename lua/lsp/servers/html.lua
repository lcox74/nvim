return {
    name = "html",
    cmd = "vscode-html-language-server",
    config = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { "index.html", "package.json", ".git" },
    },
}
