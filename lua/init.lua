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
vim.cmd.colorscheme "moonfly"
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
-- require('colorizer').setup()

-- SECTION: whichkey
require("which-key").setup {}


-- SECTION: gitsigns
-- GitSigns setup
require('gitsigns').setup {
  keymaps = {
    noremap = true,

    ['n <leader>gn'] = { expr = true, "&diff ? \'\' : '<cmd>Gitsigns next_hunk<CR>'"},
    ['n <leader>gp'] = { expr = true, "&diff ? \'\' : '<cmd>Gitsigns prev_hunk<CR>'"},

    ['n <leader>gs'] = '<cmd>Gitsigns stage_hunk<CR>',
    ['v <leader>gs'] = ':Gitsigns stage_hunk<CR>',
    ['n <leader>gu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
    ['n <leader>gr'] = '<cmd>Gitsigns reset_hunk<CR>',
    ['v <leader>gr'] = ':Gitsigns reset_hunk<CR>',
    ['n <leader>gR'] = '<cmd>Gitsigns reset_buffer<CR>',
    ['n <leader>gp'] = '<cmd>Gitsigns preview_hunk<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
    ['n <leader>gS'] = '<cmd>Gitsigns stage_buffer<CR>',
    ['n <leader>gU'] = '<cmd>Gitsigns reset_buffer_index<CR>',
    ['n <leader>gts'] = ':Gitsigns toggle_signs<CR>',
    ['n <leader>gtn'] = ':Gitsigns toggle_numhl<CR>',
    ['n <leader>gtl'] = ':Gitsigns toggle_linehl<CR>',
    ['n <leader>gtw'] = ':Gitsigns toggle_word_diff<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
  },
}

-- SECTION: autopairs
require("nvim-autopairs").setup()

-- SECTION: cinnamon
require('cinnamon').setup()
local config = {
  fps = 50,
  name = 'slide',
}
-- SECTION: indent blankline
require("indent_blankline").setup {
  char = "│",
  show_current_context = true,
  show_end_of_line = true,
}


vim.g.cursorline_timeout = 0


