vim.g.mapleader = " "

-- Navigating between windows
vim.keymap.set('n', '<C-h>', "<C-w>h", {desc = "switch left"})
vim.keymap.set('n', '<C-j>', "<C-w>j", {desc = "switch down"})
vim.keymap.set('n', '<C-k>', "<C-w>k", {desc = "switch up"})
vim.keymap.set('n', '<C-l>', "<C-w>l", {desc = "switch right"})

-- Telescope keymaps
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
