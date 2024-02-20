local ok, jdtls = pcall(require, "jdtls")
if not ok then
    vim.notify("JDTLS not found, install with `:MasonInstall jdtls`")
    return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

return {
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    settings = {
        java = {
            home = "/Users/zafar/.sdkman/candidates/java/current",
            eclipse = {
                downloadSources = true,
            },
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
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = false,
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            importOrder = {
                "java",
                "javax",
                "com",
                "org",
            },
        },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
    },
    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        jvm_args = {},
    },
}
