return {
  "nvim-colorizer.lua",
  after = function()
    require("colorizer").setup()
  end,
  keys = {

    { "<leader>c", "<cmd> ColorizerToggle<CR>", desc = "toggle Colorizer" },
  },
}
