local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  -- capabilities can be passed directly if you have modified them
  capabilities = capabilities, 
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
    },
  },
})

-- Configure the settings for nil_ls
vim.lsp.config("nil_ls", {
  cmd = { "nil" }, -- You usually need to explicitly provide the binary command in native config
  filetypes = { "nix" },
  root_markers = { "flake.nix", "shell.nix", ".git" },
  settings = {
     ['nil'] = {
        formatting = {
           command = { "nixfmt" },
        },
     },
  },
})

-- Configure the settings for lua_ls
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (Neovim uses LuaJIT)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Enable the server
vim.lsp.enable({"rust_analyzer", "nil_ls", "lua_ls"})

