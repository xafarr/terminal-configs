local api = vim.api
local augroup = neoutils.get_augroup

-- Check if we need to reload the file when it changed
api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = "*",
  group = augroup("highlight_yank"),
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto toggle hlsearch
local ns = api.nvim_create_namespace("toggle_hlsearch")
local function toggle_hlsearch(char)
  if vim.fn.mode() == "n" then
    local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end
vim.on_key(toggle_hlsearch, ns)

-- windows to close with "q"
api.nvim_create_autocmd("FileType", {
  pattern = {
    "OverseerForm",
    "OverseerList",
    "PlenaryTestPopup",
    "checkhealth",
    "floggraph",
    "fugitive",
    "git",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

api.nvim_create_autocmd("FileType", {
  pattern = "cheat",
  command = [[nnoremap <buffer><silent> q :bdelete!<CR>]],
})

-- hidden buffer
api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "TelescopePrompt" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Change shiftwidth when changing filetypes
api.nvim_create_autocmd("FileType", {
  pattern = { "java", "csharp", "bash", "sh", "groovy", "zsh" },
  group = augroup("override_tabwidth"),
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- show cursor line only in active window
api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.cursorline = true
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { link = "NvimTreeCursorLineInactive" })
    if vim.bo.filetype == "NvimTree" then
      vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { link = "NvimTreeCursorLineActive" })
    end
  end,
  group = augroup("cursorline"),
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "NvimTree" then
      vim.opt.cursorline = false
    end
  end,
  group = augroup("cursorline"),
})

-- don't auto comment new line
api.nvim_create_autocmd("BufWinEnter", { pattern = "*", command = [[set formatoptions-=cro]] })

-- create directories when needed, when saving a file
api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  command = [[call mkdir(expand('<afile>:p:h'), 'p')]],
})

-- mark the last edited position across buffers
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = 'execute "normal! mI"',
})

-- Check if we need to reload the file when it changed
api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- Resize NvimTree if window got resized
api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize nvim-tree if nvim window got resized",

  group = augroup("NvimTreeResize"),
  callback = function()
    local width = neoutils.NvimTreeWidth(neoconfigs.editor.nvimtree.width)
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabdo NvimTreeResize " .. width)
  end,
})

-- Colorize the file path in Telescope results
api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
    end)
  end,
})

-- Format command
api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("plugins.lsp.config.formatter").format(nil, range)
end, { range = true })

-- Linting
api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = neoutils.get_augroup("lint"),
  callback = function()
    require("lint").try_lint()
  end,
})

--  Use :AutoFormatToggle to toggle autoformatting on or off
api.nvim_create_user_command("AutoFormatToggle", function()
  neoconfigs.format_on_save = not neoconfigs.format_on_save
  print("Setting autoformatting to: " .. tostring(neoconfigs.format_on_save))
end, {})

api.nvim_create_autocmd("ColorScheme", {
  group = augroup("custom_highlights_colorscheme"),
  pattern = { "edge", "catppuccin" },
  callback = function(args)
    if vim.o.background == "light" then
      require("config.colorscheme.override").override_highlight(args.match)
    end
  end,
})
