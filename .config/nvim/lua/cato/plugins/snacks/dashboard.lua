local icons = require("cato.util").icons
local header = [[                                   
		      __                _            
		   /\ \ \___  ___/\   /(_)_ __ ___   
		  /  \/ / _ \/ _ \ \ / | | '_ ` _ \  
		 / /\  |  __| (_) \ V /| | | | | | | 
		 \_\ \/ \___|\___/ \_/ |_|_| |_| |_| 
		                                     ]]

return {
	width = 80,
	row = nil, -- dashboard position. nil for center
	col = nil, -- dashboard position. nil for center
	pane_gap = 4,
	preset = {
		pick = "telescope.nvim",
		keys = {
			{ icon = icons.dashboard.new_file, key = "n", desc = "New File", action = ":ene | startinsert" },
			{
				icon = icons.dashboard.file_name,
				key = "f",
				desc = "Find File",
				action = "<leader>ff",
			},
			{
				icon = icons.dashboard.file_grep,
				key = "g",
				desc = "Find Text",
				action = "<leader>ft",
			},
			{
				icon = icons.dashboard.file_recent,
				key = "r",
				desc = "Recent Files",
				action = "<leader>fr",
			},
			{
				icon = icons.dashboard.lazy,
				key = "L",
				desc = "Lazy",
				action = ":Lazy",
				enabled = package.loaded.lazy ~= nil,
			},
			{ icon = icons.dashboard.exit, key = "q", desc = "Quit", action = ":qa" },
		},
		header = header,
	},
	sections = {
		{ section = "header", height = 10 },
		{
			pane = 2,
			cmd = "tty-clock -sc",
			padding = 1,
			section = "terminal",
			height = 10,
		},
		{ section = "keys", gap = 1, padding = 1 },
		{
			action = function()
				Snacks.gitbrowse()
			end,
			desc = "Browse Repo",
			icon = " ",
			key = "b",
			padding = 1,
			pane = 2,
		},
		function()
			local in_git = Snacks.git.get_root() ~= nil
			local cmds = {
				{
					cmd = "git --no-pager diff --stat -B -M -C",
					height = 10,
					icon = icons.git.branch,
					title = "Git Status",
				},
				{
					action = function()
						vim.fn.jobstart("gh pr list --web", { detach = true })
					end,
					cmd = "gh pr list -L 3 --author '!dependabot'",
					height = 7,
					icon = " ",
					key = "p",
					title = "Open PRs",
				},
			}
			return vim.tbl_map(function(cmd)
				return vim.tbl_extend("force", {
					section = "terminal",
					enabled = in_git,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
					pane = 2,
				}, cmd)
			end, cmds)
		end,
		{ section = "startup" },
	},
}
