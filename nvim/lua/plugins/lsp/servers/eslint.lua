local M = {}
local config = {
  settings = {
    validate = "on",
    codeAction = {
      disableRuleComment = {
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
}
function M.setup_and_get_config()
  return config
end

return M
