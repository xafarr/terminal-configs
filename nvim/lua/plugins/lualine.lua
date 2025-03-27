return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      { "AndreM222/copilot-lualine" },
    },
    config = function()
      local lualine = require("lualine")
      local icons = require("config.icons")

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic", "coc" },
        sections = { "error", "warn" },
        symbols = { error = icons.diagnostics.BoldError, warn = icons.diagnostics.BoldWarning },
        colored = true,
        update_in_insert = false,
        always_visible = true,
      }

      local copilot = {
        "copilot",
        -- Default values
        symbols = {
          status = {
            icons = {
              enabled = icons.copilot.Enabled,
              sleep = icons.copilot.Sleep,
              disabled = icons.copilot.Disabled,
              warning = icons.copilot.Warning,
              unknown = icons.copilot.Unknown,
            },
            hl = {
              enabled = "#50FA7B",
              sleep = "#AEB7D0",
              disabled = "#6272A4",
              warning = "#FFB86C",
              unknown = "#FF5555",
            },
          },
          spinners = require("copilot-lualine.spinners").dots,
          spinner_color = "#6272A4",
        },
        show_colors = true,
        show_loading = true,
      }

      local diff = {
        "diff",
        colored = true,
        diff_color = {
          -- Same color values as the general color option can be used here.
          added = "DiffAdd", -- Changes the diff's added color
          modified = "DiffChange", -- Changes the diff's modified color
          removed = "DiffDelete", -- Changes the diff's removed color you
        },
        symbols = {
          added = icons.git.LineAdded,
          modified = icons.git.LineModified,
          removed = icons.git.LineRemoved,
        }, -- changes diff symbols
        cond = hide_in_width,
      }

      local mode = {
        "mode",
        fmt = function(str)
          return str
        end,
      }

      local filetype = {
        "filetype",
        icons_enabled = true,
      }

      local branch = {
        "branch",
        icons_enabled = true,
        icon = neoutils.git_host_icon() .. icons.git.Branch,
      }

      -- total lines
      local total_lines = function()
        return vim.fn.line("$")
      end

      -- location in file
      local location = function()
        local line = vim.fn.line(".")
        local col = vim.fn.col(".")
        return string.format("ln:%d/%d col:%d", line, total_lines(), col)
      end

      local filename = {
        "filename",
        path = 1,
        shorting_target = 120,
      }

      -- cool function for progress
      local progress = function()
        local current_line = vim.fn.line(".")
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines()
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end

      local spaces = function()
        local bufnr = vim.api.nvim_get_current_buf()
        return "spaces:" .. vim.api.nvim_get_option_value("shiftwidth", { buf = bufnr })
      end

      local recording = {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      }

      lualine.setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          --component_separators = { left = '', right = ''},
          --section_separators = { left = '', right = ''},
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
          always_divide_middle = true,
        },
        globalstatus = true,
        refresh = {
          statusline = 300,
          tabline = 300,
          winbar = 300,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { branch, diff },
          lualine_c = { filename },
          lualine_x = { recording, diagnostics, spaces, filetype },
          lualine_y = { location },
          lualine_z = { progress },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "nvim-tree", "fugitive", "quickfix", "toggleterm" },
      })
    end,
  },
}
