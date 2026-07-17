vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close buffer" })

-- Duplicate lines
vim.keymap.set("n", "<C-d>", "yyp", { desc = "Duplicate line" })
vim.keymap.set("v", "<C-d>", "y'<P", { desc = "Duplicate selection" })

vim.keymap.set("i", "jj", "<Esc>", { noremap = false })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

vim.api.nvim_create_user_command("W", ":w", {})
