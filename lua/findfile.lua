-- SECTION: nvim-tree
local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	open_on_tab = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},

	view = {
		width = 25,
		side = "left",
		adaptive_size = true,
		hide_root_folder = false,
	},
	git = {
		enable = false,
		ignore = true,
	},

	filesystem_watchers = {
		enable = true,
	},

	actions = {
		open_file = {
			quit_on_open = true,
			resize_window = true,
		},
	},

	renderer = {
		highlight_git = false,
		highlight_opened_files = "none",
		indent_markers = {
			enable = false,
		},
		add_trailing = false,
		group_empty = false,
	},
	diagnostics = {
		enable = true,
	},
	filters = {
		dotfiles = false,
	},
})

vim.keymap.set("n", "<leader>tt", "<cmd> NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd> NvimTreeFocus<CR>")
vim.keymap.set("n", "<leader>tg", "<cmd> NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>tr", "<cmd> NvimTreeRefresh<CR>")

-- SECTION: telescope
local telescope = require("telescope")
telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		pickers = {
			find_command = {
				"fd",
			},
		},
	},
})

telescope.load_extension("noice")
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
vim.keymap.set("n", "<leader>fvw", "<cmd> Telescope git_commits<CR>")
vim.keymap.set("n", "<leader>fvs", "<cmd> Telescope git_status<CR>")
vim.keymap.set("n", "<leader>fvx", "<cmd> Telescope git_stash<CR>")
