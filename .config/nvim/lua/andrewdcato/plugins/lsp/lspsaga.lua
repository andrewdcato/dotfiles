local lspsaga_ok, lspsaga = pcall(require, "lspsaga")
if not lspsaga_ok then
	return
end

lspsaga.setup({
	ui = {
		winblend = 10,
		border = "rounded",
	},
	symbol_in_winbar = {
		enable = false, -- remember the week you spent two days trying to figure out why you coudn't turn navic off?
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Diagnostics && Signatures
-- keymap("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>")
-- keymap("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
-- keymap("n", "<leader>db", "<cmd>Lspsaga show_buf_diagnostics<CR>")
-- keymap("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- keymap("n", "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
--
-- -- Diagnostic jump with filter like Only jump to error
-- keymap("n", "[E", function()
-- 	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end)
-- keymap("n", "]E", function()
-- 	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end)
--
-- keymap("i", "<C-k>", "<cmd>Lspsaga signature_help<CR>", opts)
--
-- -- GoTos
-- keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
-- keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
-- keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
-- keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
-- keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
--
-- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
-- keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
--
-- -- Code Actions
-- keymap({ "n", "v" }, "<leader>ca", "<CMD>Lspsaga code_action<CR>", opts)
--
-- -- Outline
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
