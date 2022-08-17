local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
-- Open new line below and above current line
keymap("n", "<Leader>o", "o<Esc>", opts)
keymap("n", "<Leader>O", "O<Esc>", opts)

keymap('n', '*', '*zz', opts)

-- search occurrence count in file
keymap("n", "<leader>*", "*<C-O>:%s///gn<CR>``", opts)

-- Copy until end of line
keymap("n", "Y", "y$", opts)

-- Move text up and down
keymap("n", "∆", ":m .+1<CR>==", opts)
keymap("n", "˚", ":m .-2<CR>==", opts)

-- search occurrence count in file
keymap("n", "<leader>*", "*<C-O>:%s///gn<CR>``", opts)

-- Windows navigation
keymap("n", "<S-Tab>", "<C-w>W", opts)
keymap("n", "<Tab>", "<C-w>w", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Telescope Keymaps
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>b", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>\"", ":Telescope neoclip<CR>", opts)
keymap("n", "<leader>q", ":Telescope macroscope<CR>", opts)

-- Insert --
-- move line up and down in insert mode
keymap("i", "∆", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "˚", "<Esc>:m .-2<CR>==gi", opts)

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
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "∆", ":move '>+1<CR>gv-gv", opts)
keymap("x", "˚", ":move '<-2<CR>gv-gv", opts)

