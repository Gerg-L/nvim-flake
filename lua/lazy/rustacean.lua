return {
  "rustaceanvim",
  lazy = false,
  after = function()
    vim.g.rustaceanvim = {
      tools = {
        code_actions = {
          ui_select_fallback = true,
        },
      },
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "crate",
              importEnforceGranularity = true,
            },
            inlayHints = {
              typeHints = { enable = true },
              chainingHints = { enable = true },
              bindingModeHints = { enable = true },
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "always" },
              maxLength = 5,
              enable = true,
            },
            lens = { enable = true },
            checkOnSave = {
              command = "clippy",
              allFeatures = true,
            },
          },
        },
      },
      on_attach = function(_, bufnr)
        WK.add({
          { "<leader>r", desc = "Rust" },
          {
            "<leader>rr",
            ":RustLsp runnables<CR>",
            desc = "Runnables",
          },
          {
            "<leader>rp",
            ":RustLsp parentModule<CR>",
            desc = "Parent module",
          },
          {
            "<leader>rm",
            ":RustLsp expandMacro<CR>",
            desc = "Expand macro",
          },
          {
            "<leader>rc",
            ":RustLsp openCargo",
            desc = "Open crate",
          },
          {
            "<leader>rg",
            ":RustLsp crateGraph x11",
            desc = "Crate graph",
          },
          {
            "<leader>rd",
            ":RustLsp debuggables<cr>",
            desc = "Debuggables",
          },
        }, { noremap = true, silent = true, buffer = bufnr })
      end,
    }
  end,
}
