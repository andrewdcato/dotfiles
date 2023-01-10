-- Map leader to a space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Navigation
-- Move through splits w/ CTRL + {h,j,k,l}
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Window splits
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make splits equal
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split

-- Tabs
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- move to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- move to prev tab

-- General remaps
keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear search higlights
keymap.set("n", "<leader>+", "<C-a>") -- increment numbers
keymap.set("n", "<leader>-", "<C-x>") -- decrement numbers

-- Plugin keymaps
-- nvim-tree
keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>") -- open tree
keymap.set("n", "<leader>j", ":NvimTreeFindFile<CR>") -- find files

-- telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fc", ":Telescope grep_string<CR>")
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
keymap.set("n", "<leader>fh", ":Telescope help_tags")

-- lazygit
keymap.set("n", "<leader>gg", ":LazyGit<CR>")
keymap.set("n", "<leader>gc", ":LazyGitConfig<CR>")

