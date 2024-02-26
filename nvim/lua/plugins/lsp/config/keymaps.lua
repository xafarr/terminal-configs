local M = {}

local keymap = vim.keymap -- for conciseness

local opts = { noremap = true, silent = true }

function M.on_attach(client, buffer)
  opts.buffer = buffer

  -- set keybinds
  opts.desc = "Show LSP references"
  keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

  opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

  opts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

  opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

  opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

  opts.desc = "Next Diagnostic"
  keymap.set("n", "]d", M.diagnostic_goto(true), opts)

  opts.desc = "Prev Diagnostic"
  keymap.set("n", "[d", M.diagnostic_goto(false), opts)

  opts.desc = "Next Error"
  keymap.set("n", "]e", M.diagnostic_goto(true, "ERROR"), opts)

  opts.desc = "Prev Error"
  keymap.set("n", "[e", M.diagnostic_goto(false, "ERROR"), opts)

  opts.desc = "Next Warning"
  keymap.set("n", "]w", M.diagnostic_goto(true, "WARNING"), opts)

  opts.desc = "Prev Warning"
  keymap.set("n", "[w", M.diagnostic_goto(false, "WARNING"), opts)

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

  opts.desc = "Restart LSP"
  keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary   keymap("gd", "Telescope lsp_definitions", opts)

  opts.desc = "Document Symbols"
  keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)

  opts.desc = "Workspace Symbols"
  keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
