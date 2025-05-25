return {
  "oil.nvim",
  lazy = false,
  after = function()
    require("oil").setup({
      keymaps = {
        ["<C-c>"] = false,
        ["<leader>o"] = "actions.close",
      },
    })
  end,
  wk = {
    { "<leader>o", "<CMD>Oil<CR>", desc = "Toggle Oil" },
  },
}
