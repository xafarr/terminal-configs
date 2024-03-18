local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Keymaps
-- Any mode
keymap("", "<C-a>", "<esc>ggVG<CR>", opts)

-- Normal

-- Format file or range keymap
vim.keymap.set(
  { "n", "v" },
  "<leader>,",
  ":Format<CR>",
  { noremap = true, silent = true, desc = "Format file or range (in Visual mode)" }
)

-- Troggle lazygit in terminal
keymap("n", "<leader>lg", ":lua neoutils.lazygit_toggle()<CR>", opts)

-- Open new line below and above current line
keymap("n", "<leader>o", "o<Esc>", opts)
keymap("n", "<leader>O", "O<Esc>", opts)

keymap("n", "*", "*zz", opts)

-- Delete a word backwards
keymap("n", "<M-BS>", "<Esc>db", opts)
keymap("n", "<M-BS>", "<Esc>db", opts)

-- Better viewing
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "g,", "g,zvzz", opts)
keymap("n", "g;", "g;zvzz", opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', opts)

-- Faster scrolling
keymap("n", "<C-e>", "3<C-e>", opts)
keymap("n", "<C-y>", "3<C-y>", opts)

-- search occurrence count in file
keymap("n", "<leader>*", "*<C-O>:%s///gn<CR>``", opts)

-- Copy until end of line
keymap("n", "Y", "y$", opts)

-- Do not write to last register when deleting with x
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)

-- Move text up and down
keymap("n", "∆", ":m .+1<CR>==", opts)
keymap("n", "˚", ":m .-2<CR>==", opts)
keymap("n", "<M-j>", ":m .+1<CR>==", opts)
keymap("n", "<M-k>", ":m .-2<CR>==", opts)

-- search occurrence count in file
keymap("n", "<leader>*", "*<C-O>:%s///gn<CR>``", opts)

-- Windows navigation
-- keymap("n", "<S-Tab>", "<C-w>W", opts)
-- keymap("n", "<Tab>", "<C-w>w", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Jump to last changed position across buffers
-- Refer to autocommands.lua for InsertChange event
keymap("n", "<BS>", "`I", opts)

-- vim help for word under cursor
keymap("n", "<F1>", ":h <C-r><C-w><cr>", opts)

-- Insert --
-- move line up and down in insert mode
keymap("i", "∆", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "˚", "<Esc>:m .-2<CR>==gi", opts)
keymap("i", "<M-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<M-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Movement in insert mode
keymap("i", "<C-h>", "<C-o>h", opts)
keymap("i", "<C-l>", "<C-o>a", opts)
keymap("i", "<C-j>", "<C-o>j", opts)
keymap("i", "<C-k>", "<C-o>k", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "∆", ":m '>+1<CR>gv=gv", opts)
keymap("v", "˚", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<M-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<M-k>", ":m '<-2<CR>gv=gv", opts)

-- Do not overwrite clipboard when pasting
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "∆", ":move '>+1<CR>gv-gv", opts)
keymap("x", "˚", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<M-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<M-k>", ":move '<-2<CR>gv-gv", opts)

-- Termianl --
-- Cursor movement among windows in terminal mode
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Command --

-- Esc in the command mode act as Enter (Accepts the command)
-- Look at the following link for more info
-- https://github.com/neovim/neovim/issues/21585
keymap("c", "<Esc>", "<C-c>", opts)
