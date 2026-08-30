return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  cmd = { "ClaudeCode" },
  config = function()
    require("claude-code").setup()
  end,
}
