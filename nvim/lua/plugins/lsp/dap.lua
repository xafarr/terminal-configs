return {
  {
    "mfussenegger/nvim-dap",
    event = "BufRead",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      { "theHamsta/nvim-dap-virtual-text" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "jay-babu/mason-nvim-dap.nvim" },
    },
    config = function(plugin, opts)
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      local dap, dapui = require("dap"), require("dapui")
      local icons = require("config.icons")
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = icons.dap.Pause,
            play = icons.dap.Play,
            step_into = icons.dap.StepInto,
            step_over = icons.dap.StepOver,
            step_out = icons.dap.StepOut,
            step_back = icons.dap.StepBack,
            run_last = icons.dap.RunLast,
            terminate = icons.dap.Terminate,
          },
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "leoluz/nvim-dap-go",
    },
    cmd = { "DapInstall", "DapUninstall" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "delve",
          "kotlin-debug-adapter",
          "debugpy",
        },
        automatic_installation = false,
        handlers = {},
      })

      -- Setup golang dap specific config
      require("dap-go").setup()
    end,
  },
}
