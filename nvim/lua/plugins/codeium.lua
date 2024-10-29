return {
  {
    "Exafunction/codeium.nvim",
    cmd = { "Codeium" },
    config = function()
      require("codeium").setup({
        enable_chat = true,
        enable_cmp_source = true,
      })
    end,
  },
}
