local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
    "BufReadPost",
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- windows to close with "q"
api.nvim_create_autocmd("FileType", {
    pattern = { "help", "startuptime", "qf", "lspinfo", "fugitive", "git", "vim", "toggleterm" },
    command = [[nnoremap <buffer><silent> q :close<CR>]],
})
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })
api.nvim_create_autocmd("FileType", { pattern = "cheat", command = [[nnoremap <buffer><silent> q :bdelete!<CR>]] })

-- hidden buffer
api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "TelescopePrompt" },
    command = [[set nobuflisted]],
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- don't auto comment new line
api.nvim_create_autocmd("BufWinEnter", { pattern = "*", command = [[set formatoptions-=cro]] })

-- create directories when needed, when saving a file
api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
    command = [[call mkdir(expand('<afile>:p:h'), 'p')]],
})

-- mark the last edited position across buffers
api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = 'execute "normal! mI"',
})

-- Check if we need to reload the file when it changed
api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })

-- vim resize event (don't know what it does)
api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})
