return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      local comment = require("Comment")

      comment.setup({
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---ignores empty lines
        ignore = "^$",
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = "<leader>cc",
          ---Block-comment toggle keymap
          block = "<leader>bc",
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = "<leader>c",
          ---Block-comment keymap
          block = "<leader>c",
        },
        ---LHS of extra mappings
        extra = {
          ---Add comment on the line above
          above = "<leader>cO",
          ---Add comment on the line below
          below = "<leader>co",
          ---Add comment at the end of line
          eol = "<leader>cA",
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
        },

        -- integrate nvim-ts-context-commentstring using pre_hook to easily comment tsx/jsx files.
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

        post_hook = nil,
      })
    end,
  },
}
