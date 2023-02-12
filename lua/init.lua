-- dark bakground
-- stop hiding double quotes in json files
vim.g.indentLine_setConceal = 0
-- plugin setups
-- SECTION: nvim-tree
-- file expolorer
vim.g.loaded = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup {
  open_on_setup = false,
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}
vim.keymap.set("n", "<leader>tt", "<cmd> NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd> NvimTreeFocus<CR>")
vim.keymap.set("n", "<leader>tg", "<cmd> NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>tr", "<cmd> NvimTreeRefresh<CR>")
require("nvim-web-devicons").setup()

-- SECTION: treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = {},
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
-- Treesitter Context config
require'treesitter-context'.setup {
  enable = true,
  throttle = true,
  max_lines = 0
}
-- SECTION: show hex colors
require('colorizer').setup()

-- SECTION: telescope
local telescope = require('telescope')
telescope.setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    },
    pickers = {
      find_command = {
        "fd",
      },
    },
  }
}

telescope.load_extension('noice')
telescope.load_extension('fzy_native')
vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd> Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags<CR>")
vim.keymap.set("n", "<leader>flD", "<cmd> Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<leader>fld", "<cmd> Telescope diagnostics<CR>")
vim.keymap.set("n", "<leader>fli", "<cmd> Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<leader>flr", "<cmd> Telescope lsp_references<CR>")
vim.keymap.set("n", "<leader>fls", "<cmd> Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>fls", "<cmd> Telescope lsp_workspace_symbols<CR>")
vim.keymap.set("n", "<leader>flt", "<cmd> Telescope lsp_type_definitions<CR>")
vim.keymap.set("n", "<leader>fs", "<cmd> Telescope treesitter<CR>")
vim.keymap.set("n", "<leader>ft", "<cmd> Telescope<CR>")
vim.keymap.set("n", "<leader>fvb", "<cmd> Telescope git_branches<CR>")
vim.keymap.set("n", "<leader>fvc", "<cmd> Telescope git_bcommits<CR>")
vim.keymap.set("n", "<laeader>fvw", "<cmd> Telescope git_commits<CR>")
vim.keymap.set("n", "<leader>fvs", "<cmd> Telescope git_status<CR>")
vim.keymap.set("n", "<leader>fvx", "<cmd> Telescope git_stash<CR>")

-- SECTION: whichkey
local wk = require("which-key").setup {}

require('gitsigns').setup {
  current_line_blame = true,
}
require("nvim-autopairs").setup()



-- SECTION: theme
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.moonflyCursorColor = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = true
vim.g.moonflyUndercurls = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme "moonfly"
