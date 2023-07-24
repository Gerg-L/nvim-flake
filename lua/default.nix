(builtins.concatStringsSep "\n")
(
  map (x: "luafile ${x}")
  [
    ./init.lua
    ./lsp.lua
    ./completion.lua
    ./treesitter.lua
    ./lualine.lua
    ./noice.lua
    ./gitsigns.lua
    ./bufferline.lua
    ./findfile.lua
  ]
)
