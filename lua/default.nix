(builtins.concatStringsSep "\n")
(
  map (x: builtins.readFile x)
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
