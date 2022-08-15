local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local status_ok, actions = pcall(require, "telescope.actions")
if not status_ok then
	return
end

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    layout_config = {
      preview_width = 80,
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
