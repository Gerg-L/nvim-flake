return {
  "fzf-lua",
  cmd = "FzfLua",
  event = "DeferredUIEnter",
  after = function()
    vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --inline-info"
    require("fzf-lua").setup({ "telescope" })
  end,
  keys = {
    { "<leader>ff", "<cmd> FzfLua files<CR>", desc = "fzf files" },
    { "<leader>fg", "<cmd> FzfLua live_grep_native<CR>", desc = "fzf ripgrep (native)" },
    { "<leader>fG", "<cmd> FzfLua live_grep<CR>", desc = "fzf ripgrep" },
    { "<leader>fr", "<cmd> FzfLua resume<CR>", desc = "fzf resume" },
    { "<leader>fb", "<cmd> FzfLua buffers<CR>", desc = "fzf buffers" },
    { "<leader>la", "<cmd> FzfLua lsp_code_actions<CR>", desc = "fzf code actions" },
  },

  wk = {
    { "<leader>f", desc = "Fuzzy find" },
  },
}
