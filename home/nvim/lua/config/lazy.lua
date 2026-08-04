local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Tell lazy.nvim to store the lockfile in ~/.local/state/nvim/ where it can write
    lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",

    spec = {
        -- Core LazyVim plugins
        { "LazyVim/LazyVim",                          import = "lazyvim.plugins" },

        -- Language Extras
        { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.nix" },

        -- Disable Mason
        { "mason-org/mason.nvim",                     enabled = false },
        { "mason-org/mason-lspconfig.nvim",           enabled = false },

        -- Load custom plugins from lua/plugins/
        { import = "plugins" },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
