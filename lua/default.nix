''
vim.cmd([[
    ${builtins.readFile ./basic.vim}
]])

${builtins.readFile ./init.lua}
${builtins.readFile ./lsp.lua}
${builtins.readFile ./completion.lua}
${builtins.readFile ./lualine.lua}
${builtins.readFile ./noice.lua}
${builtins.readFile ./bufferline.lua}
${builtins.readFile ./findfile.lua}
vim.cmd([[
    nnoremap <silent><leader>b1 <Cmd>BufferLineGoToBuffer 1<CR>
    nnoremap <silent><leader>b2 <Cmd>BufferLineGoToBuffer 2<CR>
    nnoremap <silent><leader>b3 <Cmd>BufferLineGoToBuffer 3<CR>
    nnoremap <silent><leader>b4 <Cmd>BufferLineGoToBuffer 4<CR>
    nnoremap <silent><leader>b5 <Cmd>BufferLineGoToBuffer 5<CR>
    nnoremap <silent><leader>b6 <Cmd>BufferLineGoToBuffer 6<CR>
    nnoremap <silent><leader>b7 <Cmd>BufferLineGoToBuffer 7<CR>
    nnoremap <silent><leader>b8 <Cmd>BufferLineGoToBuffer 8<CR>
    nnoremap <silent><leader>b9 <Cmd>BufferLineGoToBuffer 9<CR>
    nnoremap <silent><leader>bc :BufferLinePick<CR>
    nnoremap <silent><leader>bmn :BufferLineMoveNext<CR>
    nnoremap <silent><leader>bmp :BufferLineMovePrev<CR>
    nnoremap <silent><leader>bn :BufferLineCycleNext<CR>
    nnoremap <silent><leader>bp :BufferLineCyclePrev<CR>
    nnoremap <silent><leader>bsd :BufferLineSortByDirectory<CR>
    nnoremap <silent><leader>bse :BufferLineSortByExtension<CR>
]])
''



