local opts = { noremap = true, silent = true }

WK.add({
  { "<leader>lg", desc = "Decs/Defs" },

  {
    "<leader>lgD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    desc = "Decleration",
    opts,
  },
  {
    "<leader>lgd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    desc = "Definition",
    opts,
  },
  {
    "<leader>lgt",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    desc = "Type definition",
    opts,
  },
  {
    "<leader>lgn",
    "<cmd>lua vim.diagnostic.goto_next()<CR>",
    desc = "Next diagnostic",
    opts,
  },
  {
    "<leader>lgp",
    "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    desc = "Prev diagnostic",
    opts,
  },
  { "<leader>lw", desc = "Workspace" },
  {
    "<leader>lwa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    desc = "Add workspace folder",
    opts,
  },
  {
    "<leader>lwr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    desc = "Remove workspace folder",
    opts,
  },
  {
    "<leader>lwl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    desc = "List workspace folders",
    opts,
  },
  {
    "<leader>lh",
    "<cmd>lua vim.lsp.buf.hover()<CR>",
    desc = "Hover info",
    opts,
  },
  {
    "<leader>ls",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    desc = "Signature info",
    opts,
  },
  {
    "<leader>ln",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    desc = "Rename variable",
    opts,
  },
  {
    "<leader>lf",
    function()
      vim.lsp.buf.format({ async = true })
    end,
    desc = "Format buffer",
  },
  { "<leader>l", desc = "LSP" },
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
})

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

-- Rust config
require("crates").setup({
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
})

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
    local rust_opts = { noremap = true, silent = true, buffer = bufnr }
    WK.add({
      { "<leader>r", desc = "Rust" },
      {
        "<leader>rr",
        ":RustLsp runnables<CR>",
        desc = "Runnables",
        rust_opts,
      },
      {
        "<leader>rp",
        ":RustLsp parentModule<CR>",
        desc = "Parent module",
        rust_opts,
      },
      {
        "<leader>rm",
        ":RustLsp expandMacro<CR>",
        desc = "Expand macro",
        rust_opts,
      },
      {
        "<leader>rc",
        ":RustLsp openCargo",
        desc = "Open crate",
        rust_opts,
      },
      {
        "<leader>rg",
        ":RustLsp crateGraph x11",
        desc = "Crate graph",
        rust_opts,
      },
      {
        "<leader>rd",
        ":RustLsp debuggables<cr>",
        desc = "Debuggables",
        rust_opts,
      },
    })
  end,
}
-- CCLS (clang) config

lspconfig.ccls.setup({
  capabilities = capabilities,
  cmd = { "ccls" },
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
})
