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
vim.opt.guicursor = "i:block"
vim.g.cursorline_timeout = 0

vim.opt.shortmess:append({ I = true, c = true })

vim.opt.exrc = true

WK = require("which-key")
WK.setup()
WK.add({ " ", "<Nop>", { silent = true, remap = false } })
vim.g.mapleader = " "

--theming
vim.opt.termguicolors = true
-- use single border for windows
vim.opt.winborder = "single"

vim.g.moonflyCursorColor = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = true
vim.g.moonflyUndercurls = false
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme("moonfly")

-- stop hiding double quotes in json files
vim.g.indentLine_setConceal = 0

WK.add({
  { "Q", "<Nop>", { noremap = false } },
})
-- keymaps
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
  },
  {
    mode = { "x" },
    { "<leader>p", '"_dP' },
  },
})

-- automatically create directories on save if they don't exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "PageConnect",
  callback = function()
    vim.opt.spell = false
  end,
})
