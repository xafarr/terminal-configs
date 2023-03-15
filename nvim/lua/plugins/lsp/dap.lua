return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "theHamsta/nvim-dap-virtual-text" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "jay-babu/mason-nvim-dap.nvim" },
        },
        -- stylua: ignore
        keys = {
            { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
            { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
            { "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
            { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI", },
            { "<leader>db", function() require("dap").step_back() end, desc = "Step Back", },
            { "<F9>", function() require("dap").continue() end, desc = "Continue", },
            { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
            { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Evaluate", },
            { "<leader>dg", function() require("dap").session() end, desc = "Get Session", },
            { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables", },
            { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
            { "<F7>", function() require("dap").step_into() end, desc = "Step Into", },
            { "<F8>", function() require("dap").step_over() end, desc = "Step Over", },
            { "<leader>dp", function() require("dap").pause.toggle() end, desc = "Pause", },
            { "<leader>dq", function() require("dap").close() end, desc = "Quit", },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
            { "<leader>ds", function() require("dap").continue() end, desc = "Start", },
            { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
            { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
            { "<leader>du", function() require("dap").step_out() end, desc = "Step Out", },
        },
        config = function(plugin, opts)
            require("nvim-dap-virtual-text").setup({
                commented = true,
            })

            local dap, dapui = require("dap"), require("dapui")
            dapui.setup({})

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "BufRead",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
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
                automatic_setup = true, -- Recommended, but optional
            })
            require("mason-nvim-dap").setup_handlers({
                function(source_name)
                    require("mason-nvim-dap.automatic_setup")(source_name)
                end,
            })
        end,
    },
}
