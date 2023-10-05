local attach_keymaps = function(_, _)
  local opts = { noremap = true, silent = true }
  vim.keymap.set( "n", "<leader>lgD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set( "n", "<leader>lgd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set( "n", "<leader>lgt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.keymap.set( "n", "<leader>lgn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.keymap.set( "n", "<leader>lgp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.keymap.set( "n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.keymap.set( "n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.keymap.set(
    "n",
    "<leader>lwl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.keymap.set( "n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.keymap.set( "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.keymap.set( "n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set( "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set('n', '<leader>lf', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local ls_sources = {
  formatting.stylua,
  formatting.rustfmt,
  --formatting.alejandra,
  code_actions.statix,
  diagnostics.deadnix,
}

-- Enable formatting
local format_callback = function(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      if vim.g.formatsave then
        local params = require("vim.lsp.util").make_formatting_params({})
        client.request("textDocument/formatting", params, nil, bufnr)
      end
    end,
  })
end
local default_on_attach = function(client, bufnr)
  attach_keymaps(client, bufnr)
  format_callback(client, bufnr)
end
-- Enable null-ls
require("null-ls").setup({
  diagnostics_format = "[#{m}] #{s} (#{c})",
  debounce = 250,
  default_timeout = 5000,
  sources = ls_sources,
  on_attach = default_on_attach,
})
-- Enable lspconfig
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Rust config
local rt = require("rust-tools")
local rust_on_attach = function(client, bufnr)
  default_on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>ris", rt.inlay_hints.set, opts)
  vim.keymap.set("n", "<leader>riu", rt.inlay_hints.unset, opts)
  vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, opts)
  vim.keymap.set("n", "<leader>rp", rt.parent_module.parent_module, opts)
  vim.keymap.set("n", "<leader>rm", rt.expand_macro.expand_macro, opts)
  vim.keymap.set("n", "<leader>rc", rt.open_cargo_toml.open_cargo_toml, opts)
  vim.keymap.set("n", "<leader>rg", function()
    rt.crate_graph.view_crate_graph("x11", nil)
  end, opts)
end
local rustopts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = false,
    inlay_hints = {
      only_current_line = false,
    },
  },
  server = {
    capabilities = capabilities,
    on_attach = rust_on_attach,
    cmd = { "rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        experimental = {
          procAttrMacros = true,
        },
      },
    },
  },
}
require("crates").setup({
  null_ls = {
    enabled = true,
    name = "crates.nvim",
  },
})
rt.setup(rustopts)
-- Nix (nil) config

lspconfig.nil_ls.setup({
  capabilities = capabilities,
  on_attach = default_on_attach,
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
require("lspconfig").lua_ls.setup({
  on_attach = default_on_attach,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        },
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
})
-- CCLS (clang) config

lspconfig.ccls.setup({
  capabilities = capabilities,
  on_attach = default_on_attach,
  cmd = { "ccls" },
})
