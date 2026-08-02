return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                rust_analyzer = {},
                nil_ls = {},
                lua_ls = {},
                bashls = {},
            },
        },
    },
}
