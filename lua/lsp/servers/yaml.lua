return {
    name = "yamlls",
    cmd = "yaml-language-server",
    config = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yaml.docker-compose" },
        root_markers = { ".git" },
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    ["https://json.schemastore.org/github-action.json"] = "/action.yml",
                    ["https://json.schemastore.org/docker-compose.json"] = "/docker-compose*.yml",
                },
                validate = true,
                completion = true,
                hover = true,
            },
        },
    },
}
