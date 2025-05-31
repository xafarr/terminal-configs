local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local function get_opts(props)
  local keymap_opts = { noremap = true, silent = true }
  for k, v in pairs(props) do
    keymap_opts[k] = v
  end
  return keymap_opts
end

local function diagnostic_goto(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = next, severity = severity, float = true })
  end
end

-- Keymaps
-- Any mode
keymap.set("", "<C-a>", "<esc>ggVG<CR>", opts)

--- General Keymaps
-- Normal
-- Format file or range keymap
keymap.set({ "n", "v" }, "<leader>,", ":Format<CR>", get_opts({ desc = "Format file or range (in Visual mode)" }))

-- Troggle lazygit in terminal
keymap.set("n", "<leader>lg", ":lua neoutils.lazygit_toggle()<CR>", opts)

-- Open new line below and above current line
keymap.set("n", "<leader>o", "o<Esc>", opts)
keymap.set("n", "<leader>O", "O<Esc>", opts)

keymap.set("n", "*", "*zz", opts)

-- Delete a word backwards
keymap.set("n", "<M-BS>", "<Esc>db", opts)
keymap.set("n", "<M-BS>", "<Esc>db", opts)

-- Better viewing
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "g,", "g,zvzz", opts)
keymap.set("n", "g;", "g;zvzz", opts)

-- Paste over currently selected text without yanking it
keymap.set({ "v", "x" }, "<leader>p", '"_dP', opts)

-- Faster scrolling
keymap.set("n", "<C-e>", "3<C-e>", opts)
keymap.set("n", "<C-y>", "3<C-y>", opts)

-- search occurrence count in file
keymap.set("n", "<leader>*", "*<C-O>:%s///gn<CR>``", opts)

-- Copy until end of line
keymap.set("n", "Y", "y$", opts)

-- Do not write to last register when deleting with x
keymap.set("n", "x", '"_x', opts)
keymap.set("n", "X", '"_X', opts)

-- Move text up and down
keymap.set("n", "∆", ":m .+1<CR>==", opts)
keymap.set("n", "˚", ":m .-2<CR>==", opts)
keymap.set("n", "<M-j>", ":m .+1<CR>==", opts)
keymap.set("n", "<M-k>", ":m .-2<CR>==", opts)

-- search occurrence count in file
keymap.set("n", "<leader>*", "*<C-O>:%s///gn<CR>``", opts)

-- Windows navigation
-- keymap("n", "<S-Tab>", "<C-w>W", opts)
-- keymap("n", "<Tab>", "<C-w>w", opts)
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Jump to last changed position across buffers
-- Refer to autocommands.lua for InsertChange event
keymap.set("n", "<BS>", "`I", opts)

-- vim help for word under cursor
keymap.set("n", "<F1>", ":h <C-r><C-w><cr>", opts)

-- Insert --
-- move line up and down in insert mode
keymap.set("i", "∆", "<Esc>:m .+1<CR>==gi", opts)
keymap.set("i", "˚", "<Esc>:m .-2<CR>==gi", opts)
keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Movement in insert mode
keymap.set("i", "<C-h>", "<C-o>h", opts)
keymap.set("i", "<C-l>", "<C-o>a", opts)
keymap.set("i", "<C-j>", "<C-o>j", opts)
keymap.set("i", "<C-k>", "<C-o>k", opts)

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "∆", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "˚", ":m '<-2<CR>gv=gv", opts)
keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", opts)

-- Do not overwrite clipboard when pasting
keymap.set("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap.set("x", "∆", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "˚", ":move '<-2<CR>gv-gv", opts)
keymap.set("x", "<M-j>", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "<M-k>", ":move '<-2<CR>gv-gv", opts)

-- Termianl --
-- Cursor movement among windows in terminal mode
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Command --

-- Esc in the command mode act as Enter (Accepts the command)
-- Look at the following link for more info
-- https://github.com/neovim/neovim/issues/21585
keymap.set("c", "<Esc>", "<C-c>", opts)

-- Telescope keymaps --
keymap.set("n", "<leader><space>", neoutils.find_files, get_opts({ desc = "Find Files" }))
keymap.set("n", "<leader>ff", neoutils.find_files, get_opts({ desc = "Find Files" }))
keymap.set("n", "<leader>fg", neoutils.git_files, get_opts({ desc = "Find Within Git Repository" }))
keymap.set("n", '<leader>f"', "<cmd>Telescope neoclip<cr>", get_opts({ desc = "Clipboard" }))
keymap.set("n", "<leader>fq", "<cmd>Telescope macroscope<cr>", get_opts({ desc = "Macros" }))
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", get_opts({ desc = "Buffers" }))
keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", get_opts({ desc = "Browser" }))
keymap.set("n", "<leader>ps", "<cmd>Telescope repo list<cr>", get_opts({ desc = "Search" }))
keymap.set("n", "<leader>vh", "<cmd>Telescope help_tags<cr>", get_opts({ desc = "Search" }))
keymap.set("n", "<leader>pp", function()
  require("telescope").extensions.project.project({ display_type = "minimal" })
end, get_opts({ desc = "List" }))
keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>", get_opts({ desc = "Workspace" }))
keymap.set("n", "<leader>sb", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, get_opts({ desc = "Buffer" }))
keymap.set("n", "<leader>vo", "<cmd>Telescope aerial<cr>", get_opts({ desc = "Code Outline" }))
keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, get_opts({ desc = "Colorscheme" }))

-- LSP Keymaps
-- show definition, references
keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", get_opts({ desc = "Show LSP references" }))
-- go to declaration
keymap.set("n", "gD", vim.lsp.buf.declaration, get_opts({ desc = "Go to declaration" }))
-- show lsp definitions
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", get_opts({ desc = "Show LSP definitions" }))
-- show lsp implementations
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", get_opts({ desc = "Show LSP implementations" }))
-- show lsp type definitions
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", get_opts({ desc = "Show LSP type definitions" }))
-- see available code actions, in visual mode will apply to selection
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, get_opts({ desc = "See available code actions" }))
-- smart rename
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, get_opts({ desc = "Smart rename" }))
-- show  diagnostics for file
keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", get_opts({ desc = "Show buffer diagnostics" }))
-- show diagnostics for line
-- 1 = next, -1 = previous
keymap.set("n", "<leader>d", vim.diagnostic.open_float, get_opts({ desc = "Show line diagnostics" }))
keymap.set("n", "]d", diagnostic_goto(1), get_opts({ desc = "Next Diagnostic" }))
keymap.set("n", "[d", diagnostic_goto(-1), get_opts({ desc = "Prev Diagnostic" }))
keymap.set("n", "]e", diagnostic_goto(1, "ERROR"), get_opts({ desc = "Next Error" }))
keymap.set("n", "[e", diagnostic_goto(-1, "ERROR"), get_opts({ desc = "Prev Error" }))
keymap.set("n", "]w", diagnostic_goto(1, "WARNING"), get_opts({ desc = "Next Warning" }))
keymap.set("n", "[w", diagnostic_goto(-1, "WARNING"), get_opts({ desc = "Prev Warning" }))
-- show documentation for what is under cursor
keymap.set("n", "K", vim.lsp.buf.hover, get_opts({ desc = "Show documentation for what is under cursor" }))
-- mapping to restart lsp if necessary   keymap("gd", "Telescope lsp_definitions", opts)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", get_opts({ desc = "Restart LSP" }))
keymap.set(
  "n",
  "<leader>ds",
  require("telescope.builtin").lsp_document_symbols,
  get_opts({ desc = "Document Symbols" })
)
keymap.set(
  "n",
  "<leader>ws",
  require("telescope.builtin").lsp_dynamic_workspace_symbols,
  get_opts({ desc = "Workspace Symbols" })
)

-- DAP Keymaps --

 -- stylua: ignore start
keymap.set("n", "<leader>dR", function() require("dap").run_to_cursor() end, get_opts({desc = "Run to Cursor"}))
keymap.set("n", "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, get_opts({desc = "Evaluate Input"}))
keymap.set("n", "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, get_opts({desc = "Conditional Breakpoint"}))
keymap.set("n", "<leader>dU", function() require("dapui").toggle() end, get_opts({desc = "Toggle UI"}))
keymap.set("n", "<leader>db", function() require("dap").step_back() end, get_opts({desc = "Step Back"}))
keymap.set("n", "<F9>", function() require("dap").continue() end, get_opts({desc = "Continue"}))
keymap.set("n", "<leader>dd", function() require("dap").disconnect() end, get_opts({desc = "Disconnect"}))
keymap.set({"n", "v"}, "<leader>de", function() require("dapui").eval() end, get_opts({desc = "Evaluate"}))
keymap.set("n", "<leader>dg", function() require("dap").session() end, get_opts({desc = "Get Session"}))
keymap.set("n", "<leader>dh", function() require("dap.ui.widgets").hover() end, get_opts({desc = "Hover Variables"}))
keymap.set("n", "<leader>dS", function() require("dap.ui.widgets").scopes() end, get_opts({desc = "Scopes"}))
keymap.set("n", "<F7>", function() require("dap").step_into() end, get_opts({desc = "Step Into"}))
keymap.set("n", "<F8>", function() require("dap").step_over() end, get_opts({desc = "Step Over"}))
keymap.set("n", "<leader>dp", function() require("dap").pause.toggle() end, get_opts({desc = "Pause"}))
keymap.set("n", "<leader>dq", function() require("dap").close() end, get_opts({desc = "Quit"}))
keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, get_opts({desc = "Toggle REPL"}))
keymap.set("n", "<leader>ds", function() require("dap").continue() end, get_opts({desc = "Start"}))
keymap.set("n", "<leader>dt", function() require("dap").toggle_breakpoint() end, get_opts({desc = "Toggle Breakpoint"}))
keymap.set("n", "<leader>dx", function() require("dap").terminate() end, get_opts({desc = "Terminate"}))
keymap.set("n", "<leader>du", function() require("dap").step_out() end, get_opts({desc = "Step Out"}))
-- stylua: ignore end
