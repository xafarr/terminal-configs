local M = {}

-- Disable autoformat on save by default
M.format_on_save = false

M.uname = vim.loop.os_uname()
M.OS = M.uname.sysname
M.ARCH = M.uname.machine

M.DAP = {
  enabled = true,
}

M.lazy = {
  defaults = {
    lazy = true,
  },
  default_to_current_colorscheme = true,
}

M.editor = {
  enabled = true,
  nvimtree = {
    width = 30, -- pecentage wrt neovim window
  },
  treesitter = {
    parsers = {},
  },
}

M.UI = {
  colorscheme = "catppuccin",
  colors_override = {
    enabled = false,
  },
}

M.stdDataPath = vim.fn.stdpath("data")
M.stdConfigPath = vim.fn.stdpath("config")
M.stdCachePath = vim.fn.stdpath("cache")

M.language_servers = {
  "angularls",
  "ansiblels",
  "bashls",
  "bicep",
  "clangd",
  "cmake",
  "csharp_ls",
  "cssls",
  "dockerls",
  "gopls",
  "gradle_ls",
  "groovyls",
  "graphql",
  "html",
  "jdtls", -- Java Language Server
  "jsonls",
  "kotlin_language_server",
  "lemminx", -- XML Language Server
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "terraformls",
  "ts_ls",
  "vimls",
  "vuels",
  "yamlls",
}

M.mason_tools = {
  -- List formatters and linters here, when available in mason.
  "ansible-lint",
  "black",
  "clang-format",
  "csharpier",
  "eslint_d",
  "flake8",
  "gofumpt",
  "goimports",
  "golangci-lint",
  "isort",
  "java-debug-adapter",
  "java-test",
  "jq",
  "ktlint",
  "markdownlint-cli2",
  "npm-groovy-lint",
  "prettier",
  "pylint",
  "shellcheck",
  "shfmt",
  "sql-formatter",
  "stylua",
  "tflint",
  "yamlfmt",
  "xmlformatter",
}

_G.neoconfigs = M
