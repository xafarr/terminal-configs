local M = {}
local config = {
  settings = {

    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [neoconfigs.stdConfigPath .. "/lua"] = true,
        },
      },
    },
  },
}
function M.setup_and_get_config()
  return config
end

return M
