local java_filetypes = { "java" }
-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end

-- Set up nvim-jdtls to attach to java files.
return {
  "mfussenegger/nvim-jdtls",
  dependencies = { "folke/which-key.nvim" },
  ft = java_filetypes,
  opts = function()
    local root_dir = require("jdtls.setup").find_root({ "pom.xml", "mvnw", "gradlew", "build.gradle" })
    local project_name = vim.fs.basename(root_dir)

    return {
      -- This is the default if not provided, you can remove it. Or adjust as needed.
      -- One dedicated LSP server & client will be started per unique root_dir
      root_dir = root_dir,
      -- How to run jdtls. This can be overridden to a full java command-line
      -- if the Python wrapper script doesn't suffice.
      cmd = { vim.fn.exepath("jdtls") },
      full_cmd = function(opts)
        local cmd = vim.deepcopy(opts.cmd)
        if project_name then
          vim.list_extend(cmd, {
            "-configuration",
            neoconfigs.stdCachePath .. "/jdtls/" .. project_name .. "/config",
            "-data",
            neoconfigs.stdCachePath .. "/jdtls/" .. project_name .. "/workspace",
          })
        end
        return cmd
      end,
      settings = {
        java = {
          home = os.getenv("JAVA_HOME"),
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "interactive",
            runtimes = {},
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
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          signatureHelp = { enabled = true },
          completion = {
            enabled = true,
            importOrder = {
              "java",
              "javax",
              "com",
              "org",
            },
          },
        },
      },
      -- These depend on nvim-dap, but can additionally be disabled by setting false here.
      dap = { hotcodereplace = "auto", config_overrides = {} },
      test = true,
      flags = {
        allow_incremental_sync = true,
      },
      init_options = {
        jvm_args = {},
        bundles = {},
      },
    }
  end,
  config = function()
    local ok, jdtls = pcall(require, "jdtls")
    if not ok then
      vim.notify("JDTLS not found, install with `:MasonInstall jdtls`")
      return
    end

    -- import cmp-nvim-lsp plugin
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

    -- Used to enable autocompletion
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {}
    )

    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local opts = neoutils.opts("nvim-jdtls") or {}

    -- Find the extra bundles that should be passed on the jdtls command-line
    -- if nvim-dap is enabled with java debug/test.
    local mason_registry = require("mason-registry")
    local bundles = {} ---@type string[]
    if opts.dap and neoutils.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
      local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
      local java_dbg_path = java_dbg_pkg:get_install_path()
      local jar_patterns = {
        java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
      }
      -- java-test also depends on java-debug-adapter.
      if opts.test and mason_registry.is_installed("java-test") then
        local java_test_pkg = mason_registry.get_package("java-test")
        local java_test_path = java_test_pkg:get_install_path()
        vim.list_extend(jar_patterns, {
          java_test_path .. "/extension/server/*.jar",
        })
      end
      for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
          table.insert(bundles, bundle)
        end
      end
    end

    local function attach_jdtls()
      -- Configuration can be augmented and overridden by opts.jdtls
      local config = extend_or_override({
        cmd = opts.full_cmd(opts),
        root_dir = opts.root_dir,
        init_options = {
          bundles = bundles,
        },
        -- enable CMP capabilities
        capabilities = capabilities,
        settings = opts.settings,
        extendedClientCapabilities = extendedClientCapabilities,
        flags = opts.flags,
      }, opts.jdtls)

      -- Existing server will be reused if the root_dir matches.
      jdtls.start_or_attach(config)
      -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
    end

    -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
    -- depending on filetype, so this autocmd doesn't run for the first file.
    -- For that, we call directly below.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = java_filetypes,
      callback = attach_jdtls,
    })

    -- Setup keymap and dap after the lsp is fully attached.
    -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
    -- https://neovim.io/doc/user/lsp.html#LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "jdtls" then
          local keymaps = require("plugins.lsp.config.keymaps")
          local formatter = require("plugins.lsp.config.formatter")
          local wk = require("which-key")

          keymaps.on_attach(client, args.buf)
          formatter.on_attach(client, args.buf)

          wk.register({
            ["<leader>cx"] = { name = "+extract" },
            ["<leader>cxv"] = { jdtls.extract_variable_all, "Extract Variable" },
            ["<leader>cxc"] = { jdtls.extract_constant, "Extract Constant" },
            ["gs"] = { jdtls.super_implementation, "Goto Super" },
            ["gS"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
            ["<leader>co"] = { jdtls.organize_imports, "Organize Imports" },
          }, { mode = "n", buffer = args.buf })
          wk.register({
            ["<leader>c"] = { name = "+code" },
            ["<leader>cx"] = { name = "+extract" },
            ["<leader>cxm"] = {
              [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
              "Extract Method",
            },
            ["<leader>cxv"] = {
              [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
              "Extract Variable",
            },
            ["<leader>cxc"] = {
              [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
              "Extract Constant",
            },
          }, { mode = "v", buffer = args.buf })

          if opts.dap and neoutils.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
            -- custom init for Java debugger
            jdtls.setup_dap(opts.dap)
            require("jdtls.dap").setup_dap_main_class_configs()

            -- Java Test require Java debugger to work
            if opts.test and mason_registry.is_installed("java-test") then
              -- custom keymaps for Java test runner (not yet compatible with neotest)
              wk.register({
                ["<leader>t"] = { name = "+test" },
                ["<leader>tt"] = { require("jdtls.dap").test_class, "Run All Test" },
                ["<leader>tr"] = { require("jdtls.dap").test_nearest_method, "Run Nearest Test" },
                ["<leader>tT"] = { require("jdtls.dap").pick_test, "Run Test" },
              }, { mode = "n", buffer = args.buf })
            end
          end
        end
      end,
    })
  end,
}
