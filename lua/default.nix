''
  " Prepended viml config

''
+ ((builtins.concatStringsSep "\n")
  (
    map (x: "luafile ${x}")
    [
      #
      # All files listed here end up getting called with "luafile <file>"
      #
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
  ))
+ ''

  " Appended viml config
''
