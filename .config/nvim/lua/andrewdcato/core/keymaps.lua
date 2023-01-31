-- Map leader to a space
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Navigation
-- Move through splits w/ CTRL + {h,j,k,l}
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Window splits
keymap("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", opts) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", opts) -- make splits equal
keymap("n", "<leader>sx", ":close<CR>", opts) -- close current split

-- Tabs
keymap("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>", opts) -- move to next tab
keymap("n", "<leader>tp", ":tabp<CR>", opts) -- move to prev tab

-- General remaps
keymap("n", "<leader>nh", ":nohl<CR>", opts) -- clear search higlights
keymap("n", "<leader>+", "<C-a>", opts) -- increment numbers
keymap("n", "<leader>-", "<C-x>", opts) -- decrement numbers

-- Plugin keymaps
-- nvim-tree
keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts) -- open tree
keymap("n", "<leader>j", ":NvimTreeFindFile<CR>", opts) -- find files

-- telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fs", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fc", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fp", ":Telescope packer<CR>", opts)

-- lazygit
keymap("n", "<leader>gg", ":LazyGit<CR>", opts)
keymap("n", "<leader>gc", ":LazyGitConfig<CR>", opts)

-- nvim-dap
keymap("n", "<F5>", ":lua require('dap')continue()", opts)
keymap("n", "<F10>", ":lua require('dap')step_over()", opts)
keymap("n", "<F11>", ":lua require('dap')step_into()", opts)
keymap("n", "<F12>", ":lua require('dap')step_out()", opts)
keymap("n", "<leader>b", ":lua require('dap')toggle_breakpoint()", opts)

-- nvim-dap-ui
keymap("n", "<leader>dt", ":lua require('dapui')toggle()", opts)

-- trouble
keymap("n", "<leader>xx", ":TroubleToggle<cr>", opts)
keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>xq", ":TroubleToggle quickfix<cr>", opts)
keymap("n", "<leader>xl", ":TroubleToggle loclist<cr>", opts)
keymap("n", "gR", ":TroubleToggle lsp_references<cr>", opts)
