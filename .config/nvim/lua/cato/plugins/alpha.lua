return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local plugins = require("lazy")
		local headers = require("cato.util").ascii_headers
		local icons = require("cato.util").icons
		dashboard.section.header.val = headers[math.random(#headers)]

		dashboard.section.buttons.val = {
			dashboard.button("e", icons.dashboard.new_file .. "Create new file", "<cmd>ene <BAR> startinsert<cr>"),
			dashboard.button("g", icons.dashboard.lazygit .. "Open LazyGit", "<cmd>LazyGit<cr>"),
			dashboard.button(
				"f",
				icons.dashboard.file_name .. "Search by file name",
				"<cmd>Telescope find_files hidden=true<cr>"
			),
			dashboard.button(
				"r",
				icons.dashboard.file_recent .. "Search recently used files",
				"<cmd>Telescope oldfiles<cr>"
			),
			dashboard.button(
				"t",
				icons.dashboard.file_grep .. "Search by text in file",
				"<cmd>Telescope live_grep<cr>"
			),
			dashboard.button("q", icons.dashboard.exit .. "Quit Neovim", "<cmd>qa<cr>"),
		}

		-- Footer must be a table so that its height is correctly measured
		local nvim_stats = plugins.stats()
		if nvim_stats.count <= 1 then
			dashboard.section.footer.val = {
				"Neovim loaded " .. nvim_stats.count .. " plugin 󰚥 in " .. nvim_stats.startuptime .. "ms",
			}
		else
			dashboard.section.footer.val = {
				"Neovim loaded " .. nvim_stats.count .. " plugins 󰚥 in " .. nvim_stats.startuptime .. "ms",
			}
		end
		dashboard.section.footer.opts.hl = "Comment"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		-- Set paddings
		local h_header = #dashboard.section.header.val
		local h_buttons = #dashboard.section.buttons.val * 2 - 1
		local h_footer = #dashboard.section.footer.val
		local pad_tot = vim.o.lines - (h_header + h_buttons + h_footer)
		local pad_1 = math.ceil(pad_tot * 0.25)
		local pad_2 = math.ceil(pad_tot * 0.20)
		local pad_3 = math.floor(pad_tot * 0.30)

		dashboard.config.layout = {
			{ type = "padding", val = pad_1 },
			dashboard.section.header,
			{ type = "padding", val = pad_2 },
			dashboard.section.buttons,
			{ type = "padding", val = pad_3 },
			dashboard.section.footer,
		}

		vim.cmd(
			[[ au User AlphaReady if winnr('$') == 1 | set laststatus=0 showtabline=0 | endif | au BufUnload <buffer> set laststatus=3 showtabline=2 ]]
		)

		vim.api.nvim_create_autocmd("BufUnload", {
			buffer = 0,
			desc = "show cursor after alpha",
			callback = function()
				local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
				hl.blend = 0
				vim.api.nvim_set_hl(0, "Cursor", hl)
				vim.opt.guicursor:remove("a:Cursor/lCursor")
			end,
		})

		alpha.setup(dashboard.opts)
	end,
}
