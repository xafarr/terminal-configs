-- JDTLS (Java LSP) configuration
local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify("JDTLS not found, install with `:MasonInstall jdtls`")
  return
end
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local mason_share_path = neoconfigs.stdDataPath .. "/mason/share"
local workspace_dir = mason_share_path .. "/jdtls/jdtls-workspace/" .. project_name
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local _extendedClientCapabilities = jdtls.extendedClientCapabilities
_extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Needed for debugging
local bundles = {
  vim.fn.glob(mason_share_path .. "/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
}

-- Needed for running/debugging unit tests
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_share_path .. "/java-test/*.jar", true), "\n"))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. mason_share_path .. "/jdtls/lombok.jar",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    mason_share_path .. "/jdtls/plugins/org.eclipse.equinox.launcher.jar",
    "-configuration",
    mason_share_path .. "/jdtls/config",
    "-data",
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = vim.fs.root(0, { ".git", "mvnw", "pom.xml", "gradlew", "settings.gradle", "settings.gradle.kts" }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      -- TODO Replace this with the absolute path to your main java version (JDK 17 or higher)
      home = os.getenv("JAVA_HOME"),
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-17",
            path = neoutils.get_java_install_path(17),
          },
          {
            name = "JavaSE-21",
            path = neoutils.get_java_install_path(21),
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
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      format = {
        enabled = true,
        -- Formatting works by default, but you can refer to a specific file/URL if you choose
        settings = {
          url = "https://raw.githubusercontent.com/xafarr/terminal-configs/refs/heads/master/styleguide/java-code-style.xml",
          profile = "GoogleStyle",
        },
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      import = {
        gradle = {
          enabled = true,
        },
        maven = {
          enabled = true,
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**",
        },
      },
    },
    completion = {
      favoriteStaticMembers = {
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.hamcrest.CoreMatchers.*",
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  -- Needed for auto-completion with method signatures and placeholders
  capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
  ),

  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    jvm_args = {},
    -- References the bundles defined above to support Debugging and Unit Testing
    bundles = bundles,
    extendedClientCapabilities = _extendedClientCapabilities,
  },
}

-- Needed for debugging
config["on_attach"] = function(client, bufnr)
  local formatter = require("plugins.lsp.config.formatter")
  local wk = require("which-key")
  local mason_registry = require("mason-registry")

  formatter.on_attach(client, bufnr)

  wk.add({
    { "<leader>co", jdtls.organize_imports, desc = "Organize Imports" },
    { "<leader>cx", group = "+extract", mode = { "n", "v" } }, -- group
    { "<leader>cxv", jdtls.extract_variable_all, desc = "Extract Variable" },
    { "<leader>cxc", jdtls.extract_constant, desc = "Extract Constant" },
    { "<leader>cxm", jdtls.extract_method, desc = "Extract Method" },
    { "<leader>gs", jdtls.goto_super_class, desc = "Goto Super" },
    { "<leader>gS", jdtls.goto_super_method, desc = "Goto Super" },
    {
      mode = { "v" },
      { "<leader>cxm", "<ESC><CMD>lua require('jdtls').extract_method(true)<CR>", desc = "Extract Method" },
      { "<leader>cxv", "<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>", desc = "Extract Variable" },
      { "<leader>cxc", "<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>", desc = "Extract Constant" },
    },
  })

  if neoutils.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
    -- custom init for Java debugger
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()

    -- Java Test require Java debugger to work
    if mason_registry.is_installed("java-test") then
      local jdap = require("jdtls.dap")
      -- custom keymaps for Java test runner (not yet compatible with neotest)
      wk.add({
        { "<leader>t", group = "+test" },
        { "<leader>tt", jdap.test_class, desc = "Run All Test" },
        { "<leader>tr", jdap.test_nearest_method, desc = "Run Nearest Test" },
        { "<leader>tT", jdap.pick_test, desc = "Run Test" },
      })
    end
  end
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
