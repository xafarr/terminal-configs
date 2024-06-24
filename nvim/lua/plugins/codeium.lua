return {
  {
    "Exafunction/codeium.nvim",
    event = { "BufEnter" },
    cmd = { "Codeium" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({ enable_chat = true })
    end,
  },
}
