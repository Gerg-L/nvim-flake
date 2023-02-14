-- SECTION: basic
vim.o.encoding='utf-8'
vim.o.mouse='a'
vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.softtabstop=2
vim.o.expandtab=true
vim.o.cmdheight=1
vim.o.updatetime=300
vim.o.shortmess = vim.o.shortmess..'c'
vim.o.tm=1000
vim.o.hidden=true
vim.o.splitbelow=true
vim.o.splitright=true
vim.o.signcolumn='yes:2'
vim.o.ai=true
vim.o.swapfile=false
vim.o.backup=false
vim.o.writebackup=false
vim.o.visualbell=false
vim.o.errorbells=false
vim.o.number = true
vim.o.relativenumber=true
vim.o.clipboard = vim.o.clipboard..'unnamedplus'
vim.o.wrap=false
vim.o.hlsearch=false
vim.o.incsearch=true
vim.o.termguicolors=true
vim.o.t_Co=256


--vim herasy
vim.cmd.aunmenu{'PopUp.How-to\\ disable\\ mouse'}
vim.cmd.aunmenu{'PopUp.-1-' }

-- map leader to <Space>
vim.keymap.set('n', ' ', '<Nop>', { silent = true, remap = false })
vim.g.mapleader = ' '

-- stop hiding double quotes in json files
vim.g.indentLine_setConceal = 0

-- SECTION: theme
vim.g.moonflyCursorColor = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = true
vim.g.moonflyUndercurls = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme 'moonfly'



-- SECTION: autopairs
require('nvim-autopairs').setup()

-- SECTION: cinnamon
require('cinnamon').setup()
local config = {
  fps = 50,
  name = 'slide',
}
-- SECTION: indent blankline
require('indent_blankline').setup {
  char = '│',
  show_current_context = true,
  show_end_of_line = true,
}


vim.g.cursorline_timeout = 0

-- SECTION: colorizer
require('colorizer').setup()
vim.keymap.set('n', '<leader>ct', '<cmd> ColorizerToggle<CR>')

-- SECTION: whichkey
require('which-key').setup {}


