return {
    name = "dockerls",
    cmd = "docker-language-server",
    config = {
        cmd = { "docker-language-server", "start", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { "Dockerfile", ".git" },
    },
}
