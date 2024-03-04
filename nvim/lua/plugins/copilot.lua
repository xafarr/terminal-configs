return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false, auto_trigger = true },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
