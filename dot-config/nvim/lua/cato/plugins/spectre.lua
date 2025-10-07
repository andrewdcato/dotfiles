return {
	"nvim-pack/nvim-spectre",
	keys = {
		{ "<leader>s", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
	},
	config = function()
		vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search current word",
		})

		vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search current word",
		})

		vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search on current file",
		})

		require("spectre").setup({
			color_devicons = true,
			live_update = true,
			open_cmd = "vnew",
			is_open_target_win = true,
			is_insert_mode = true,
			-- HACK: explanation here - https://github.com/nvim-pack/nvim-spectre/issues/118
			replace_engine = {
				["sed"] = {
					cmd = "sed",
					args = {
						"-i",
						"",
						"-E",
					},
				},
			},
		})
	end,
}
