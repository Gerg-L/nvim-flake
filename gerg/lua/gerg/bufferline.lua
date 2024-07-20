-- SECTION: nvimBufferline
require("nvim-web-devicons")
require("bufferline").setup({
  options = {
    close_command = function(bufnum)
      require("bufdelete").bufdelete(bufnum, false)
    end,
    right_mouse_command = "vertical sbuffer %d",
    indicator = {
      indicator_icon = "▎",
      style = "icon",
    },
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    separator_style = "thin",
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
    sort_by = "extension",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "" or (e == "warning" and "" or "")
        if sym ~= "" then
          s = s .. " " .. n .. sym
        end
      end
      return s
    end,
    numbers = function(opts)
      return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
    end,
  },
})
vim.diagnostic.config({ update_in_insert = true })
vim.keymap.set("n", "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>")
vim.keymap.set("n", "<leader>bc", ":BufferLinePick<CR>")
vim.keymap.set("n", "<leader>bmn", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>bmp", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>bsd", ":BufferLineSortByDirectory<CR>")
vim.keymap.set("n", "<leader>bse", ":BufferLineSortByExtension<CR>")
