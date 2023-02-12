-- SECTION: nvimBufferline
require("nvim-web-devicons")
require("bufferline").setup{
  options = {
    numbers = "both",
    close_command = function(bufnum)
      require("bufdelete").bufdelete(bufnum, false)
    end
    ,
    right_mouse_command = 'vertical sbuffer %d',
    indicator = {
      indicator_icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
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
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}},
    sort_by = 'extension',
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and ""
        or (e == "warning" and "" or "" )
        if(sym ~= "") then
          s = s .. " " .. n .. sym
        end
      end
      return s
    end,
    numbers = function(opts)
      return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
    end,
  }
}

