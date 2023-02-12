local attach_keymaps = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end
local null_ls = require("null-ls")
local null_helpers = require("null-ls.helpers")
local null_methods = require("null-ls.methods")
vim.g.formatsave = true;
-- Enable formatting
format_callback = function(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      if vim.g.formatsave then
        local params = require'vim.lsp.util'.make_formatting_params({})
        client.request('textDocument/formatting', params, nil, bufnr)
      end
    end
  })
end
default_on_attach = function(client, bufnr)
  attach_keymaps(client, bufnr)
  format_callback(client, bufnr)
end
-- Enable null-ls
require('null-ls').setup{
  diagnostics_format = "[#{m}] #{s} (#{c})",
  debounce = 250,
  default_timeout = 5000,
  sources = ls_sources,
  on_attach=default_on_attach
}
-- Enable lspconfig
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()


-- Rust config
local rt = require('rust-tools')
rust_on_attach = function(client, bufnr)
  default_on_attach(client, bufnr)
  local opts = { noremap=true, silent=true, buffer = bufnr }
  vim.keymap.set("n", "<leader>ris", rt.inlay_hints.set, opts)
  vim.keymap.set("n", "<leader>riu", rt.inlay_hints.unset, opts)
  vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, opts)
  vim.keymap.set("n", "<leader>rp", rt.parent_module.parent_module, opts)
  vim.keymap.set("n", "<leader>rm", rt.expand_macro.expand_macro, opts)
  vim.keymap.set("n", "<leader>rc", rt.open_cargo_toml.open_cargo_toml, opts)
  vim.keymap.set("n", "<leader>rg", function() rt.crate_graph.view_crate_graph("x11", nil) end, opts)
end
if vim.fn.executable('rust-analyzer') then
local rustopts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = false,
    inlay_hints = {
      only_current_line = false,
    }
  },
  server = {
    capabilities = capabilities,
    on_attach = rust_on_attach,
    cmd = {'rust-analyzer'},
    settings = {
      ['rust-analyzer'] = {
        experimental = {
          procAttrMacros = true,
        }
      }
    }
  }
}
end
require('crates').setup {
  null_ls = {
    enabled = true,
    name = 'crates.nvim',
  }
}
rt.setup(rustopts)
-- Nix (nil) config

if vim.fn.executable('nil') == 1 then
  lspconfig.nil_ls.setup{
    capabilities = capabilities,
    on_attach=default_on_attach,
    cmd = {'nil'},
    settings = {
      ["nil"] = {
        formatting = {
          command = {'alejandra', '--quiet'},
        }
      }
    }
  }
end

-- CCLS (clang) config
if vim.fn.executable('ccls') == 1 then

  lspconfig.ccls.setup{
    capabilities = capabilities;
    on_attach=default_on_attach;
    cmd = {'ccls'};
  }
end
