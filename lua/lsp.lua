local lspc = require("lspconfig")

if vim.fn.executable("rust-analyzer") == 1 then
  lspc.rust_analyzer.setup{}
end

if vim.fn.executable("nil") == 1 then
  lspc.nil_ls.setup{}
end

if vim.fn.executable("clangd") == 1 then
  lspc.clangd.setup{}
end

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    formatting.rustfmt,
    formatting.alejandra,
    code_actions.statix,
    diagnostics.deadnix,
  },
})
