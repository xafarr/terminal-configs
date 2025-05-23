local set = vim.opt

-- Colorscheme
set.background = os.getenv("THEME_BACKGROUND") or "light"

-- General Options
set.backup = false -- creates a backup file
set.clipboard = "unnamed,unnamedplus" -- allows neovim to access the system clipboard
set.cmdheight = 2 -- more space in the neovim command line for displaying messages
set.completeopt = "menu,menuone,noselect" -- mostly just for cmp
set.conceallevel = 0 -- so that `` is visible in markdown files
set.fileencoding = "utf-8" -- the encoding written to a file
set.compatible = false
set.autoread = true -- show incomplete command in status line
set.autowrite = true -- save buffer automatically when switching to another buffer
set.incsearch = true
set.hlsearch = false -- highlight all matches on previous search pattern
set.matchpairs:append("<:>")
set.ignorecase = true -- ignore case in search patterns
set.mouse = "a" -- allow the mouse to be used in neovim
set.pumheight = 10 -- pop up menu height
set.showcmd = true
set.lazyredraw = false
set.showmode = false -- we don't need to see things like -- INSERT -- anymore
set.showtabline = 0
set.laststatus = 3
set.wildmenu = true
set.ruler = true
set.smartcase = true -- smart case
set.smartindent = true -- make indenting smarter again
set.splitbelow = true -- force all horizontal splits to go below current window
set.splitright = true -- force all vertical splits to go to the right of current window
set.swapfile = false -- creates a swapfile
set.termguicolors = true -- set term gui colors (most terminals support this)
set.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
set.undofile = true -- enable persistent undo
set.updatetime = 300 -- faster completion (4000ms default)
set.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
set.expandtab = true -- convert tabs to spaces
set.shiftwidth = 2 -- the number of spaces inserted for each indentation
set.softtabstop = 2 -- insert 2 spaces for a tab
set.tabstop = 2
set.cursorline = true -- highlight the current line
set.hidden = true
set.showmatch = true
set.magic = true
set.textwidth = 120
set.backspace = "indent,eol,start"
set.list = true
set.listchars = "tab:..,eol:↩"
set.wildmode = "longest:full,full"
set.showbreak = "\\"
set.spelllang = "en_us"
set.number = true -- set numbered lines
set.relativenumber = false -- set relative numbered lines
set.numberwidth = 4 -- set number column width to 2 {default 4}
set.signcolumn = "auto:2-3" -- always show the sign column otherwise it would shift the text each time
set.wrap = true -- display lines as one long line
set.scrolloff = 8 -- is one of my fav
set.sidescrolloff = 8 -- keeps the cursor 5 lines above/below when z <cr>
set.grepprg = "rg --vimgrep"
set.grepformat = "%f:%l:%c:%m"
set.shortmess:append("c")
set.ttyfast = true
set.fillchars = "foldopen:,foldclose:,fold:⸱,foldsep: ,diff:╱,eob: "

if vim.fn.has("nvim-0.10") == 1 then
  set.smoothscroll = true
end

-- Neovide specific configuration
if vim.g.neovide then
  vim.g.neovide_cursor_antialiasing = false
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scale_factor = 1.1
else
  set.guifont = "JetBrainsMono Nerd Font,Symbols Nerd Font:h16:b,i,u,s:liga:+zero,+cv06,+cv07,+cv16,+cv18,+cv19,+cv20" -- the font used in graphical neovim applications
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- See https://www.reddit.com/r/neovim/comments/z2lhyz/when_i_insert_tab_it_expands_to_4_spaces_and_not/
vim.g.markdown_recommended_style = 0
