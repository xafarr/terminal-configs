local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify("JDTLS not found, install with `:MasonInstall jdtls`")
  return
end

local stdDataPath = neoconfigs.stdDataPath
local workspace_path = stdDataPath .. "/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local current_os = neoconfigs.getOS()
if current_os == "windows" then
  current_os = string.match(current_os, "win")
end
local arch = neoconfigs.ARCH
local config_arch = string.match(arch, "arm")
local os_config
if config_arch ~= nil or config_arch ~= "" then
  os_config = current_os .. "_" .. config_arch
else
  os_config = current_os
end

return {
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  settings = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-javaagent:" .. stdDataPath .. "/mason/packages/jdtls/lombok.jar",
      "-jar" .. stdDataPath .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
      "-configuration" .. stdDataPath .. "/mason/packages/jdtls/config_" .. os_config,
      "-data" .. workspace_dir,
    },
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
