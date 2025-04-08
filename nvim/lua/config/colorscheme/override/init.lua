local M = {}

function M.override_highlight(colorscheme)
  local _, _colorscheme = pcall(require, "config.colorscheme.override." .. colorscheme)
  _colorscheme.override_highlight()
end

return M
