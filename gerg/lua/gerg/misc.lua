--vim herasy
vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"
vim.cmd.aunmenu({ "PopUp.How-to\\ disable\\ mouse" })
vim.cmd.aunmenu({ "PopUp.-1-" })

--indenting

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes:2"
vim.opt.ai = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.visualbell = false
vim.opt.errorbells = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.opt.scrolloff = 10
vim.opt.guicursor="i:block"

vim.opt.shortmess:append({ I = true, c = true })

WK = require("which-key")
-- map leader to ,
WK.add({ " ", "<Nop>", { silent = true, remap = false } })
vim.g.mapleader = " "

--theming
vim.opt.termguicolors = true

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
