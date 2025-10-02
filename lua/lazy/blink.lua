return {
  { "lspkind.nvim" },
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    before = function()
      LZN.trigger_load("lazydev.nvim")
      LZN.trigger_load("lspkind.nvim")
    end,
    after = function()
      local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"

      require("blink.cmp").setup({
        signature = { enabled = true },
        completion = {
          menu = {
            auto_show = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            winhighlight = winhighlight,
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon = ctx.kind_icon
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        icon = dev_icon
                      end
                    else
                      icon = require("lspkind").symbolic(ctx.kind, {
                        mode = "symbol",
                      })
                    end

                    return icon .. ctx.icon_gap
                  end,

                  -- Optionally, use the highlight groups from nvim-web-devicons
                  -- You can also add the same function for `kind.highlight` if you want to
                  -- keep the highlight groups in sync with the icons.
                  highlight = function(ctx)
                    local hl = ctx.kind_hl
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        hl = dev_hl
                      end
                    end
                    return hl
                  end,
                },
              },
              treesitter = { "lsp" },
            },
          },
          ghost_text = { enabled = true },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          documentation = {
            auto_show = true,
            window = {
              winhighlight = winhighlight,
            },
            auto_show_delay_ms = 500,
          },
        },
        keymap = {
          preset = "none",
          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },

          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },

          ["<Up>"] = { "snippet_forward", "fallback" },
          ["<Down>"] = { "snippet_backward", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },

          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
        sources = {
          default = { "lazydev", "lsp", "buffer", "snippets", "path", "omni" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
        fuzzy = { implementation = "rust" },
      })
    end,
  },
}
