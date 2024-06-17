require("fzf-lua").setup({ "telescope" })

vim.keymap.set("n", "<leader>ff", "<cmd> FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd> FzfLua live_grep_native<CR>")
vim.keymap.set("n", "<leader>fG", "<cmd> FzfLua live_grep<CR>")

vim.keymap.set("n", "<leader>fd", "<cmd> FzfLua lsp_code_actions<CR>")

vim.keymap.set("n", "<leader>fr", "<cmd> FzfLua resume<CR>")

vim.keymap.set("n", "<leader>fb", "<cmd> FzfLua buffers<CR>")
