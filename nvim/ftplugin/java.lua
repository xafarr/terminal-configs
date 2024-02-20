local jdtls = require("jdtls")
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
    cmd = { "/path/to/jdt-language-server/bin/jdtls" },
    root_dir = vim.fs.dirname(
        vim.fs.find({ "pom.xml", "build.gradle", "gradlew", ".git", "mvnw" }, { upward = true })[1]
    ),
    settings = {
        java = {
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = "~/.sdkman/candidates/java/8.0.402-amzn",
                    },
                    {
                        name = "JavaSE-17",
                        path = "~/.sdkman/candidates/java/17.0.7-tem",
                    },
                    {
                        name = "JavaSE-21",
                        path = "~/.sdkman/candidates/java/21.0.2-tem",
                    },
                },
            },
            eclipse = {
                downloadSources = false,
            },
            maven = {
                downloadSources = false,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all", -- literals, all, none
                },
            },
            format = {
                enabled = false,
            },
        },
        signatureHelp = { enabled = true },
        extendedClientCapabilities = extendedClientCapabilities,
    },
}
jdtls.start_or_attach(config)
