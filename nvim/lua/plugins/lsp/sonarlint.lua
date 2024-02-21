return {
    {
        "https://gitlab.com/schrieveslaach/sonarlint.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local analyzers_path = neoconfigs.stdDataPath .. "/mason/share/sonarlint-analyzers"
            require("sonarlint").setup({
                server = {
                    cmd = {
                        "sonarlint-language-server",
                        -- Ensure that sonarlint-language-server uses stdio channel
                        "-stdio",
                        "-analyzers",
                        -- paths to the analyzers you need, using those for python and java in this example
                        vim.fn.expand(analyzers_path .. "/sonarpython.jar"),
                        vim.fn.expand(analyzers_path .. "/sonarcfamily.jar"),
                        vim.fn.expand(analyzers_path .. "/sonarjava.jar"),
                        vim.fn.expand(analyzers_path .. "/sonargo.jar"),
                        vim.fn.expand(analyzers_path .. "/sonarlintomnisharp.jar"),
                    },
                },
                filetypes = {
                    -- Tested and working
                    "python",
                    "cpp",
                    -- Requires nvim-jdtls, otherwise an error message will be printed
                    "java",
                    "go",
                    "cs",
                },
            })
        end,
    },
}
