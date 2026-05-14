local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>")
map("n", "<leader>gr", "<cmd>Gitsigns refresh<cr>")
map("n", "<leader>fm", "<cmd>lua require('conform').format({async = false})<cr>")
