return {
  "fzf-lua",
  cmd = "FzfLua",
  after = function()
    vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --inline-info"
    require("fzf-lua").setup({ "telescope", "hide" })
    FzfLua.register_ui_select()
  end,
  keys = {
    {
      "<leader>ff",
      function()
        FzfLua.files()
      end,
      desc = "fzf files",
    },
    {
      "<leader>fg",
      function()
        FzfLua.live_grep_native()
      end,
      desc = "fzf ripgrep (native)",
    },
    {
      "<leader>fG",
      function()
        FzfLua.live_grep()
      end,
      desc = "fzf ripgrep",
    },
    {
      "<leader>fr",
      function()
        FzfLua.resume()
      end,
      desc = "fzf resume",
    },
    {
      "<leader>fb",
      function()
        FzfLua.buffers()
      end,
      desc = "fzf buffers",
    },
    {
      "<leader>la",
      function()
        FzfLua.lsp_code_actions()
      end,
      desc = "fzf code actions",
    },
  },

  wk = {
    { "<leader>f", desc = "Fuzzy find" },
  },
}
