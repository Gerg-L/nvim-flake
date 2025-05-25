return {
  "lazydev.nvim",
  ft = "lua",
  after = function()
    require("lazydev").setup({
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    })
  end,
}
