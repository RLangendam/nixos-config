local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

vim.lsp.config['rust_analyzer'] = {
  default_config = {
    cmd = {'rust-analyzer'},
    filetypes = {'rust'},
    root_dir = vim.fs.root(0, {'Cargo.toml', 'rust-project.json'}),
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = 'clippy' },
      },
    },
  },
}

vim.lsp.enable('rust_analyzer')

local nvim_lsp = require("lspconfig")
nvim_lsp.nil_ls.setup({
   settings = {
      ['nil'] = {
         formatting = {
            command = { "nixfmt" },
         },
      },
   },
})

