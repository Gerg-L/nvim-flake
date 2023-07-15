(builtins.concatStringsSep "\n")
(
  map builtins.readFile
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
