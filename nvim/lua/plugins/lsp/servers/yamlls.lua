local M = {}
local config = {
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
    },
  },
}
function M.setup_and_get_config()
  return config
end

return M
