local component = require("lualine.component"):extend()
local highlight = require("lualine.highlight")

local icons = require("config.icons").codeium

---@class CodeiumComponentOptions
local default_options = {
  symbols = {
    status = {
      icons = {
        enabled = icons.Enabled,
        sleep = icons.Sleep,
        disabled = icons.Disabled,
        warning = icons.Warning,
        unknown = icons.Unknown,
      },
      hl = {
        enabled = "#50FA7B",
        sleep = "#AEB7D0",
        disabled = "#6272A4",
        warning = "#FFB86C",
        unknown = "#FF5555",
      },
    },
    -- spinners = require("copilot-lualine.spinners").dots,
    -- spinner_color = "#6272A4",
  },
  show_colors = false,
  show_loading = true,
}

function component:init(options)
  component.super.init(self, options)
  self.options = vim.tbl_deep_extend("force", default_options, options or {})
  self.highlights = { enabled = "", disabled = "", warning = "" }

  self.highlights.sleep = highlight.create_component_highlight_group(
    { fg = self.options.symbols.status.hl.sleep },
    "codeium_sleep",
    self.options
  )
  self.highlights.enabled = highlight.create_component_highlight_group(
    { fg = self.options.symbols.status.hl.enabled },
    "codeium_enabled",
    self.options
  )
  self.highlights.disabled = highlight.create_component_highlight_group(
    { fg = self.options.symbols.status.hl.disabled },
    "codeium_disabled",
    self.options
  )
  self.highlights.warning = highlight.create_component_highlight_group(
    { fg = self.options.symbols.status.hl.warning },
    "codeium_offline",
    self.options
  )
  self.highlights.unknown = highlight.create_component_highlight_group(
    { fg = self.options.symbols.status.hl.unknown },
    "codeium_unknown",
    self.options
  )
end

function component:update_status() end
