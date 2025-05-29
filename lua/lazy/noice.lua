return {
  {
    "nui.nvim",
  },
  {
    "nvim-notify",
    after = function()
      ---@diagnostic disable: missing-fields
      require("notify").setup({
        background_colour = "#000000",
      })
    end,
  },
  {
    "noice.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZN.trigger_load("nui.nvim")
      LZN.trigger_load("nvim-notify")
    end,
    after = function()
      require("noice").setup({
        routes = {
          {
            filter = {
              event = "msg_show",
              find = 'is deprecated. Run ":checkhealth vim.deprecated" for more information',
            },
            opts = { skip = true },
          },
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },

        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },

        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {},
        },
      })
    end,
  },
}
