return {
  "rainbow-delimiters.nvim",
  after = function()
    local highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    }
    vim.g.rainbow_delimiters = {
      highlight = highlight,
    }
  end,
}
