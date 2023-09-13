local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = "*",
    group = yankGrp,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Auto toggle hlsearch
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
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
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "OverseerForm",
        "OverseerList",
        "checkhealth",
        "floggraph",
        "fugitive",
        "git",
        "help",
        "lspinfo",
        "man",
        "neotest-output",
        "neotest-summary",
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
api.nvim_create_autocmd("FileType", { pattern = "cheat", command = [[nnoremap <buffer><silent> q :bdelete!<CR>]] })

-- hidden buffer
api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "TelescopePrompt" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- Change shiftwidth when changing filetypes
api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "json", "yaml" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    command = "set cursorline",
    group = cursorGrp,
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "NvimTree" then
            vim.opt.cursorline = false
        end
    end,
    group = cursorGrp,
})

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
api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- Resize NvimTree if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    desc = "Resize nvim-tree if nvim window got resized",

    group = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true }),
    callback = function()
        local width = neoconfig.NvimTreeWidth(neoconfig.editor.nvimtree.width)
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabdo NvimTreeResize " .. width)
    end,
})
