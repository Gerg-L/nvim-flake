''
vim.cmd([[
  ${builtins.readFile ./basic.vim}
]])
  ${builtins.readFile ./init.lua}
  ${builtins.readFile ./lsp.lua}
  ${builtins.readFile ./completion.lua}
  ${builtins.readFile ./lualine.lua}
  ${builtins.readFile ./noice.lua}
''
