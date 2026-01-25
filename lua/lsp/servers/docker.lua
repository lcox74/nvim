return {
    name = "dockerls",
    cmd = "docker-language-server",
    config = {
        cmd = { "docker-language-server", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { "Dockerfile", ".git" },
    },
}
