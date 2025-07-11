return {
  {
    "none-ls.nvim",
  },
  {
    "nvim-lspconfig",
    lazy = false,
    before = function()
      LZN.trigger_load("none-ls.nvim")
      LZN.trigger_load("blink.cmp")
    end,
    after = function()
      local null_ls = require("null-ls")

      -- code action sources
      local code_actions = null_ls.builtins.code_actions

      -- diagnostic sources
      local diagnostics = null_ls.builtins.diagnostics

      -- formatting sources
      local formatting = null_ls.builtins.formatting

      -- hover sources
      -- local hover = null_ls.builtins.hover

      -- completion sources
      local completion = null_ls.builtins.completion

      local ls_sources = {
        formatting.stylua,
        -- formatting.nixfmt,
        -- code_actions.gitsigns,
        diagnostics.statix,
        code_actions.statix,
        diagnostics.deadnix,
      }

      -- Enable null-ls
      null_ls.setup({
        diagnostics_format = "[#{m}] #{s} (#{c})",
        debounce = 250,
        default_timeout = 5000,
        sources = ls_sources,
      })
      -- Enable lspconfig
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.diagnostic.config({
        float = { border = "single" },
        update_in_insert = true,
        virtual_text = false,
        virtual_lines = { enable = true, current_line = true },
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          },
          numhl = {
            [vim.diagnostic.severity.WARN] = "WarningMsg",
          },
        },
      })

      -- Nix (nil) config

      lspconfig.nil_ls.setup({
        capabilities = capabilities,
        cmd = { "nil" },
        settings = {
          ["nil"] = {
            nix = {
              binary = "nix",
              maxMemoryMB = nil,
              flake = {
                autoEvalInputs = false,
                autoArchive = false,
                nixpkgsInputName = nil,
              },
            },
            formatting = {
              command = { "nixfmt", "--quiet" },
            },
          },
        },
      })
      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            format = {
              enable = true,
            },
            runtime = {
              version = "LuaJIT",
            },
            telemetry = { enable = false },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              disable = { "missing-fields" },
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })

      lspconfig.ccls.setup({
        capabilities = capabilities,
        cmd = { "ccls" },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
    end,
    wk = {
      { "<leader>l", desc = "LSP" },
      { "<leader>lg", desc = "Decs/Defs" },
      { "<leader>lw", desc = "Workspace" },
    },

    keys = AddKeyOpts({
      {
        "<leader>lgD",
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        desc = "Decleration",
      },
      {
        "<leader>lgd",
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        desc = "Definition",
      },
      {
        "<leader>lgt",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        desc = "Type definition",
      },
      {
        "<leader>lgn",
        "<cmd>lua vim.diagnostic.goto_next()<CR>",
        desc = "Next diagnostic",
      },
      {
        "<leader>lgp",
        "<cmd>lua vim.diagnostic.goto_prev()<CR>",
        desc = "Prev diagnostic",
      },
      {
        "<leader>lwa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        desc = "Add workspace folder",
      },
      {
        "<leader>lwr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        desc = "Remove workspace folder",
      },
      {
        "<leader>lwl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        desc = "List workspace folders",
      },
      {
        "<leader>lh",
        "<cmd>lua vim.lsp.buf.hover()<CR>",
        desc = "Hover info",
      },
      {
        "<leader>ls",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        desc = "Signature info",
      },
      {
        "<leader>ln",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        desc = "Rename variable",
      },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format buffer",
      },
      {
        "<leader>lT",
        (function()
          return function()
            vim.diagnostic.hide()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          end
        end)(),
        desc = "Toggle diagnostics",
      },
      {
        "<leader>lt",
        (function()
          return function()
            local enable = not vim.diagnostic.config().virtual_lines.current_line
            vim.diagnostic.config({
              underline = enable,
              virtual_lines = {
                current_line = enable,
              },
            })
          end
        end)(),
        desc = "Toggle virtual_lines",
      },
    }, { noremap = true, silent = true }),
  },
  {
    "crates.nvim",
    event = "BufEnter Cargo.toml",
    before = function()
      LZN.trigger_load("nvim-lspconfig")
    end,
    after = function()
      require("crates").setup({
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
}
