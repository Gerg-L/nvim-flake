require("oil").setup({
  keymaps = {
    ["<C-c>"] = false,
    ["<leader>o"] = "actions.close",
  },
})
WK.add({
  { "<leader>o", "<CMD>Oil<CR>", desc = "Toggle Oil" },
})
