return {
	{
		"<leader>fb",
		function()
			Snacks.picker.buffers({
				finder = "buffers",
				format = "buffer",
				hidden = false,
				unloaded = true,
				current = true,
				sort_lastused = true,
				win = {
					input = {
						keys = {
							["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
						},
					},
					list = { keys = { ["dd"] = "bufdelete" } },
				},
			})
		end,
		desc = "﬘ Search Open Buffers",
	},

	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
		desc = " Search Current Directory",
	},

	{
		"<leader>fr",
		function()
			Snacks.picker.recent()
		end,
		desc = " Open Recent Files",
	},

	{
		"<leader>fn",
		function()
			Snacks.picker.notifications()
		end,
		desc = " Notification History",
	},

	{
		"<leader>fs",
		function()
			Snacks.picker.grep()
		end,
		desc = " Live Grep Search",
	},

	{
		"<leader>fw",
		function()
			Snacks.picker.grep_word()
		end,
		desc = " Search Current Word",
		mode = { "n", "x" },
	},

	{
		"<leader>e",
		function()
			Snacks.explorer()
		end,
		desc = "File Explorer",
	},

	{
		"<leader>st",
		function()
			Snacks.picker.todo_comments()
		end,
		desc = " View TODO comments",
	},
}
