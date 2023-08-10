local spectre_ok, spectre = pcall(require, "nvim-spectre")
if not spectre_ok then
	return
end

vim.keymap.set("n", "<C-S>", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})

vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})

vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})

vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

return spectre.setup({
	color_devicons = true,
	live_update = true,
	open_cmd = "vnew",
	is_open_target_win = true,
	is_insert_mode = true,
})
