return {
  "markview.nvim",
  lazy = false,
  after = function()
    require("markview").setup({
      experimental = {
        check_rtp = false,
      },
    })
  end,
  wk = {
    {
      {
        "<leader>m",
        desc = "Markdown",
      },
      {
        "<leader>mt",
        "<cmd>Markview Toggle<CR>",
        desc = "Toggle",
      },
    },
    { noremap = true, silent = true },
  },
}
