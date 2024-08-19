require("lint").linters_by_ft = {
    -- python = { "mypy" },
    python = { "flake8" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
