WK.add({
  {
    "<leader>m",
    desc = "Markdown",
  },
  {
    "<leader>mt",
    "<cmd>Markview Toggle<CR>",
    desc = "Toggle",
  },
}, { noremap = true, silent = true })
require("markview").setup({})
