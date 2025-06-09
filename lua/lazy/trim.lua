return {
  "trim.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("trim").setup({
      ft_blocklist = { "markdown", "oil" },

      patterns = {
        [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
      },
      trim_on_write = false,

      -- highlight trailing spaces
      highlight = true,
    })
  end,
  keys = { { "<leader>t", "<CMD>Trim<CR>", desc = "Trim" } },
}
