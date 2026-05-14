local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
set("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

set("n", "<C-h>", "<C-w>h", opts)
set("n", "<C-j>", "<C-w>j", opts)
set("n", "<C-k>", "<C-w>k", opts)
set("n", "<C-l>", "<C-w>l", opts)

set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
set("n", "<leader>rn", vim.lsp.buf.rename, opts)
set("n", "gd", vim.lsp.buf.definition, opts)
set("n", "gr", ":Telescope lsp_references<CR>", opts)
set("n", "K", vim.lsp.buf.hover, opts)

set("n", "<leader>e", vim.diagnostic.open_float, opts)
set("n", "[d", vim.diagnostic.goto_prev, opts)
set("n", "]d", vim.diagnostic.goto_next, opts)

set("n", "<leader>fm", "<cmd>lua require('conform').format({async = false})<cr>", opts)
set("n", "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", opts)
set("n", "<leader>gr", "<cmd>Gitsigns refresh<cr>", opts)
