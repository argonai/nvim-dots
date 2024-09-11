-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "rust_analyzer", "gopls", "lua_ls", "volar", "csharp_ls", "texlab", "bashls", "clangd", "zls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
-- sourcekit
lspconfig.sourcekit.setup{
  filetypes = {"swift"},
  cmd = {'/usr/bin/sourcekit-lsp'},
  root_dir = lspconfig.util.root_pattern("buildServer.json", "*.xcodeproj", "*.xcworkspace", "Package.swift", "compile_commands.json", ".git")
}
