local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"

require("blink.cmp").setup({
  signature = { enabled = true, window = { border = "single" } },
  completion = {
    menu = {
      auto_show = function(ctx)
        return ctx.mode ~= "cmdline"
      end,
      winhighlight = winhighlight,
      border = "single",
      draw = { treesitter = { "lsp" } },
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
        border = "single",
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
