return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependendcies = { "kyazdani42/nvim-web-devicons", },
    config = function()
      local bufferline = require("bufferline")
      local icons = require("config.icons")

      bufferline.setup({
        options = {
          mode = "buffers",                    -- set to "tabs" to only show tabpages instead
          numbers = "none",                    -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
          right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
          left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
          middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
          -- NOTE: this plugin is designed with this icon in mind,
          -- and so changing this is NOT recommended, this is intended
          -- as an escape hatch for people who cannot bear it for whatever reason
          indicator = {
            -- icon = icons.ui.LineMiddle, -- this should be omitted if indicator style is not 'icon'
            style = "none",
          },
          buffer_close_icon = icons.ui.Close,
          modified_icon = icons.git.Modified,
          close_icon = icons.ui.BoldClose,
          left_trunc_marker = icons.ArrowCircleLeft,
          right_trunc_marker = icons.ArrowCircleRight,
          --- name_formatter can be used to change the buffer's label in the bufferline.
          --- Please note some names can/will break the
          --- bufferline so use this at your discretion knowing that it has
          --- some limitations that will *NOT* be fixed.
          name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match("%.md") then
              return vim.fn.fnamemodify(buf.name, ":t:r")
            end
          end,
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          offsets = {
            { filetype = "NvimTree", text = "File Explorer", highlight = "LineNr", text_align = "center", separator = "█" },
          },
          color_icons = true,              -- whether or not to add the filetype icon highlights
          show_buffer_icons = true,        -- disable filetype icons for buffers
          show_buffer_close_icons = true,
          show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
          show_close_icon = true,
          show_tab_indicators = false,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          -- can also be a table containing 2 custom separators
          -- [focused and unfocused]. eg: { '|', '|' }
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          --sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
          --  -- add custom logic
          --  return buffer_a.modified > buffer_b.modified
          --end
        },
        highlights = {
          fill = {
            bg = "#f3f4f4",
          },
          background = {
            bg = "#f3f4f4",
          },
          tab = {
            bg = "#f3f4f4",
          },
          tab_selected = {
            bg = "#dadbdb",
          },
          tab_close = {
            bg = "#f3f4f4",
          },
          close_button = {
            bg = "#f3f4f4",
          },
          close_button_visible = {
            bg = "#f3f4f4",
          },
          close_button_selected = {
            bg = "#dadbdb",
          },
          buffer_visible = {
            bg = "#f3f4f4",
          },
          buffer_selected = {
            bg = "#dadbdb",
          },
          numbers = {
            bg = "#f3f4f4",
          },
          numbers_visible = {
            bg = "#f3f4f4",
          },
          numbers_selected = {
            bg = "#dadbdb",
          },
          diagnostic = {
            bg = "#f3f4f4",
          },
          diagnostic_visible = {
            bg = "#f3f4f4",
          },
          diagnostic_selected = {
            bg = "#dadbdb",
          },
          hint = {
            bg = "#f3f4f4",
          },
          hint_visible = {
            bg = "#f3f4f4",
          },
          hint_selected = {
            bg = "#dadbdb",
          },
          hint_diagnostic = {
            bg = "#f3f4f4",
          },
          hint_diagnostic_visible = {
            bg = "#f3f4f4",
          },
          hint_diagnostic_selected = {
            bg = "#dadbdb",
          },
          info = {
            bg = "#f3f4f4",
          },
          info_visible = {
            bg = "#f3f4f4",
          },
          info_selected = {
            bg = "#dadbdb",
          },
          info_diagnostic = {
            bg = "#f3f4f4",
          },
          info_diagnostic_visible = {
            bg = "#f3f4f4",
          },
          info_diagnostic_selected = {
            bg = "#dadbdb",
          },
          warning = {
            bg = "#f3f4f4",
          },
          warning_visible = {
            bg = "#f3f4f4",
          },
          warning_selected = {
            bg = "#dadbdb",
          },
          warning_diagnostic = {
            bg = "#f3f4f4",
          },
          warning_diagnostic_visible = {
            bg = "#f3f4f4",
          },
          warning_diagnostic_selected = {
            bg = "#dadbdb",
          },
          error = {
            bg = "#f3f4f4",
          },
          error_visible = {
            bg = "#f3f4f4",
          },
          error_selected = {
            bg = "#dadbdb",
          },
          error_diagnostic = {
            bg = "#f3f4f4",
          },
          error_diagnostic_visible = {
            bg = "#f3f4f4",
          },
          error_diagnostic_selected = {
            bg = "#dadbdb",
          },
          modified = {
            bg = "#f3f4f4",
          },
          modified_visible = {
            bg = "#f3f4f4",
          },
          modified_selected = {
            bg = "#dadbdb",
          },
          duplicate_selected = {
            bg = "#dadbdb",
          },
          duplicate_visible = {
            bg = "#f3f4f4",
          },
          duplicate = {
            bg = "#f3f4f4",
          },
          separator_selected = {
            bg = "#dadbdb",
          },
          separator_visible = {
            bg = "#f3f4f4",
          },
          separator = {
            fg = "#dadbdb",
            bg = "#f3f4f4",
          },
          indicator_selected = {
            fg = "#dadbdb",
            bg = "#dadbdb",
          },
          indicator_visible = {
            fg = "#f3f4f4",
            bg = "#f3f4f4",
          },
          pick_selected = {
            bg = "#dadbdb",
          },
          pick_visible = {
            bg = "#f3f4f4",
          },
          pick = {
            bg = "#f3f4f4",
          },
          offset_separator = {
            fg = "#f3f4f4",
            bg = "#f3f4f4",
          },
        },
      })
    end,
  }
}
