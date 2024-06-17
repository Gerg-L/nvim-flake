require("lazydev").setup({
  enabled = function(root_dir)
    return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
  end,
})
