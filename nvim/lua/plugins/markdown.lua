return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = { "markdown" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "Personal",
          path = vim.fn.expand("~/Documents/second-brain/Personal"),
        },
        {
          name = "Work",
          path = vim.fn.expand("~/Documents/second-brain/Work"),
        },
      },
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
      },
      completion = {
        nvim_cmp = true,
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      pipe_table = { preset = "round" },
      sign = { enabled = false },
      heading = { position = "inline" },
      code = {
        right_pad = 4,
        left_pad = 2,
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
