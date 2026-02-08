vim.g._ts_force_sync_parsing = true
vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.treesitter.language._complete(),
	group = vim.api.nvim_create_augroup("LoadTreesitter", {}),
	callback = function()
		vim.treesitter.start()
	end,
})
require("nvim-treesitter").setup({
	modules = {},
	sync_install = false,
	ignore_install = {},
	ensure_installed = {},
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
