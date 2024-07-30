--vim herasy
vim.o.encoding = "utf-8"
vim.o.mouse = "a"
vim.cmd.aunmenu({ "PopUp.How-to\\ disable\\ mouse" })
vim.cmd.aunmenu({ "PopUp.-1-" })

--indenting

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.cmdheight = 1
vim.o.updatetime = 50
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.signcolumn = "yes:2"
vim.o.ai = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.visualbell = false
vim.o.errorbells = false

vim.o.number = true
vim.o.relativenumber = true

vim.o.clipboard = "unnamedplus"

vim.o.wrap = false

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.spell = true
vim.o.spelllang = "en_us"

vim.opt.scrolloff = 10
vim.opt.guicursor = ""

vim.opt.shortmess:append({ I = true, c = true })

WK = require("which-key")
-- map leader to ,
WK.add({ " ", "<Nop>", { silent = true, remap = false } })
vim.g.mapleader = " "

--theming
vim.o.termguicolors = true

vim.g.moonflyCursorColor = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = true
vim.g.moonflyUndercurls = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme("moonfly")

-- stop hiding double quotes in json files
vim.g.indentLine_setConceal = 0

--Indent blankline
require("ibl").setup({
  indent = { char = "┋" },
})

vim.g.cursorline_timeout = 0

WK.setup()

-- SECTION: colorizer
require("colorizer").setup()
WK.add({
  {
    { "<leader>c", "<cmd> ColorizerToggle<CR>", desc = "toggle Colorizer" },
  },
})

WK.add({
  {
    mode = { "v" },
    { "J", ":m '>+1<CR>gv=gv" },
    { "K", ":m '<-2<CR>gv=gv" },
  },
  {
    { "C-d>", "<C-d>zz" },
    { "C-u>", "<C-u>zz" },
    { "n", "nzzzv" },
    { "N", "Nzzzv" },
    { "Q", "<nop>" },
  },
  {
    mode = { "x" },
    { "<leader>p", '"_dP' },
  },
})
