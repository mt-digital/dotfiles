local map = vim.keymap.set

-- ===========================================
-- DEFINE HELPERS
-- ===========================================

-- Telescope & Files
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })


-- Standard Ops
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Diagnostic float" })


-- Surround (vim-surround replacement)
map("n", "ys", "<cmd>lua require('nvim-surround').surround()<cr>", { desc = "Surround" })
map("n", "cs", "<cmd>lua require('nvim-surround').change()<cr>", { desc = "Change Surround" })
map("n", "ds", "<cmd>lua require('nvim-surround').delete()<cr>", { desc = "Delete Surround" })


-- Avoid pressing shift for colon every time.
map("n", ";", ":", { desc = "Remap ; to :" })


-- nvim-surround options
map("n", "ys", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
map("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change Surround" })
map("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete Surround" })
map("x", "ys", "<Plug>(nvim-surround-visual)", { desc = "Surround Visual" })

-- Insert mode customizations
map("i", "<M-BS>", "<C-o>dB", { desc = "Delete word backward" })
map("i", "<C-s>", "<cmd>w<cr>", { desc = "Save in insert mode" })
