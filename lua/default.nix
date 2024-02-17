{ lib, self }:
''
  " Prepended viml config

''
+ lib.concatLines (
  map (x: "luafile ${self}/lua/${x}.lua") [
    #
    # All files listed here end up getting called with "luafile <file>"
    #
    "init"
    "lsp"
    "completion"
    "treesitter"
    "lualine"
    "noice"
    "gitsigns"
    "bufferline"
    "findfile"
  ]
)
+ ''

  " Appended viml config
''
