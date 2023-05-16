return {
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.fn["mkdp#util#install"]()
        end,
    },
}
