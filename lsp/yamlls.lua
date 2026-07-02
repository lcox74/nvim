-- Merged over nvim-lspconfig's yamlls defaults (cmd, filetypes, root markers)
return {
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
}
