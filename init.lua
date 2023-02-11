-- settings
-- keybind modifier
vim.g.mapleader = "'"
vim.opt.updatetime = 300
vim.opt.incsearch = true
-- backups bad
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
--formatting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- pretty numbers
vim.opt.signcolumn = "yes:2"
vim.opt.number = true
vim.opt.relativenumber = true
-- mouse 
vim.opt.mouse = "a"
-- no wrapping bs
vim.wo.wrap = false
-- dark background
vim.opt.background = "dark"
vim.opt.termguicolors = true
-- hide bottom bar for lightling
vim.g.noshowmode = true
-- stop hiding double quotes in json files
vim.g.indentLine_setConceal = 0
-- plugin setups
-- file expolorer
vim.g.loaded = 1
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
require("nvim-web-devicons").setup()
-- language support
 require("nvim-treesitter.configs").setup {
  ensure_installed = "",
	sync_install = true,
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
}
-- shapes and colors
vim.cmd[[colorscheme moonfly]]
-- pretty colors
require("colorizer").setup()
require("telescope").load_extension("fzy_native")
require("gitsigns").setup {
  current_line_blame = true,
}
require("nvim-autopairs").setup()

-- telescope keybinds
vim.keymap.set( "n", "<Leader>s", "<cmd>Telescope find_files<cr>")
-- show tree
vim.keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR>")

-- lightnline load colorscheme
vim.g.lightline = { colorscheme = "moonfly" }


-- START OF COMPLETION SETTINGS
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "cmp_tabnine" },
		{ name = "treesitter" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "vsnip" },
	},

	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
				treesitter = "[TS]",
				cmp_tabnine = "[TN]",
				vsnip = "[Snip]",
			},
		}),
	},

	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, {
			"i",
			"s",
		}),
	},
})

-- START OF LSP SETTINGS


local lspc = require("lspconfig")

if vim.fn.executable("rust-analyzer") == 1 then
  lspc.rust_analyzer.setup{}
end

if vim.fn.executable("nil") == 1 then
  lspc.nil_ls.setup{}
end

if vim.fn.executable("clangd") == 1 then
  lspc.clangd.setup{}
end

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    formatting.rustfmt,
    formatting.alejandra,
    code_actions.statix,
    diagnostics.deadnix,
  },
})
