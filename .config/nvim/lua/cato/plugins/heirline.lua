-- Blatantly borrowed from github.com/thanhvule0310 - mostly like the aesthetic / info shown in his dots but need to tweak further...
return {
	"rebelot/heirline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "neovim/nvim-lspconfig", "Zeioth/heirline-components.nvim" },
	opts = function()
		local colors = require("tokyonight.colors").setup()
		local conditions = require("heirline.conditions")
		local icons = require("cato.util").icons
		local lib = require("heirline-components.all")
		local utils = require("heirline.utils")

		conditions.buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end

		conditions.hide_in_width = function(size)
			return vim.api.nvim_get_option("columns") > (size or 120)
		end

		local Align = { provider = "%=", hl = { bg = colors.bg_statusline } }
		local Space = { provider = " " }

		local ViMode = {
			init = function(self)
				self.mode = vim.api.nvim_get_mode().mode
				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", {
						pattern = "*:*o",
						command = "redrawstatus",
					})
					self.once = true
				end
			end,
			static = {
				mode_names = {
					["!"] = "SHELL",
					["R"] = "REPLACE",
					["Rc"] = "REPLACE",
					["Rv"] = "V-REPLACE",
					["Rvc"] = "V-REPLACE",
					["Rvx"] = "V-REPLACE",
					["Rx"] = "REPLACE",
					["S"] = "S-LINE",
					["V"] = "V-LINE",
					["Vs"] = "V-LINE",
					["\19"] = "S-BLOCK",
					["\22"] = "V-BLOCK",
					["\22s"] = "V-BLOCK",
					["c"] = "COMMAND",
					["ce"] = "EX",
					["cv"] = "EX",
					["i"] = "INSERT",
					["ic"] = "INSERT",
					["ix"] = "INSERT",
					["n"] = "NORMAL",
					["niI"] = "NORMAL",
					["niR"] = "NORMAL",
					["niV"] = "NORMAL",
					["no"] = "O-PENDING",
					["noV"] = "O-PENDING",
					["no\22"] = "O-PENDING",
					["nov"] = "O-PENDING",
					["nt"] = "NORMAL",
					["ntT"] = "NORMAL",
					["r"] = "REPLACE",
					["r?"] = "CONFIRM",
					["rm"] = "MORE",
					["s"] = "SELECT",
					["t"] = "TERMINAL",
					["v"] = "VISUAL",
					["vs"] = "VISUAL",
				},
				mode_colors = {
					[""] = colors.yellow,
					[""] = colors.yellow,
					["s"] = colors.yellow,
					["!"] = colors.red,
					["R"] = colors.red1,
					["Rc"] = colors.red1,
					["Rv"] = colors.red1,
					["Rx"] = colors.red1,
					["S"] = colors.cyan,
					["V"] = colors.magenta,
					["Vs"] = colors.magenta,
					["c"] = colors.orange,
					["ce"] = colors.orange,
					["cv"] = colors.orange,
					["i"] = colors.green,
					["ic"] = colors.green,
					["ix"] = colors.green,
					["n"] = colors.blue,
					["niI"] = colors.blue,
					["niR"] = colors.blue,
					["niV"] = colors.blue,
					["no"] = colors.magenta,
					["no"] = colors.magenta,
					["noV"] = colors.magenta,
					["nov"] = colors.magenta,
					["nt"] = colors.red,
					["null"] = colors.magenta,
					["r"] = colors.cyan,
					["r?"] = colors.red,
					["rm"] = colors.cyan,
					["s"] = colors.cyan,
					["t"] = colors.red,
					["v"] = colors.magenta,
					["vs"] = colors.magenta,
				},
			},
			provider = function(self)
				return string.format(
					"%s%s %s",
					icons.vim,
					self.mode_names[self.mode:sub(1, 1)],
					icons.separators.slant_left
				)
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { bg = self.mode_colors[mode], fg = colors.bg_dark, bold = true }
			end,
			update = { "ModeChanged" },
		}

		local FileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
			condition = conditions.buffer_not_empty,
			hl = { bg = colors.bg_statusline, fg = colors.fg_dark },
		}

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
					vim.fn.fnamemodify(filename, ":t"),
					extension,
					{ default = true }
				)
			end,
			provider = function(self)
				return self.icon and (" %s "):format(self.icon)
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local FileName = {
			provider = function(self)
				local filename = vim.fn.fnamemodify(self.filename, ":t")
				if filename == "" then
					return "[No Name]"
				end
				if not conditions.width_percent_below(#filename, 0.25) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = colors.fg_dark, bold = true },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = " ● ",
				hl = { fg = colors.magenta },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "  ",
				hl = { fg = colors.red },
			},
		}

		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					return { fg = colors.fg_dark, bold = true, force = true }
				end
			end,
		}

		local Diagnostics = {
			condition = function()
				return conditions.buffer_not_empty() and conditions.hide_in_width() and conditions.has_diagnostics()
			end,
			static = {
				error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
				warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
				info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
				hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			{
				provider = function(self)
					return self.errors > 0 and ("%s%s "):format(self.error_icon, self.errors)
				end,
				hl = { fg = colors.red },
			},
			{
				provider = function(self)
					return self.warnings > 0 and ("%s%s "):format(self.warn_icon, self.warnings)
				end,
				hl = { fg = colors.yellow },
			},
			{
				provider = function(self)
					return self.info > 0 and ("%s%s "):format(self.info_icon, self.info)
				end,
				hl = { fg = colors.blue },
			},
			{
				provider = function(self)
					return self.hints > 0 and ("%s%s "):format(self.hint_icon, self.hints)
				end,
				hl = { fg = colors.cyan },
			},
		}

		FileNameBlock = utils.insert(
			FileNameBlock,
			FileIcon,
			utils.insert(FileNameModifer, FileName),
			unpack(FileFlags),
			{ provider = "%< " },
			utils.insert(Space, Diagnostics),
			{
				provider = icons.separators.inverted_slant_right,
				hl = { bg = colors.bg_statusline, fg = colors.bg_dark },
			}
		)

		local Git = {
			condition = function()
				return conditions.buffer_not_empty() and conditions.is_git_repo()
			end,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			static = {
				added_icon = icons.git.added,
				branch_icon = icons.git.branch,
				modified_icon = icons.git.modified,
				removed_icon = icons.git.removed,
			},
			hl = { bg = colors.bg_dark, fg = colors.magenta },
			Space,
			{
				provider = function(self)
					return ("%s %s"):format(self.branch_icon, self.status_dict.head)
				end,
				hl = { bold = true },
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and (" %s %s"):format(self.added_icon, count)
				end,
				hl = { fg = colors.green },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and (" %s %s"):format(self.removed_icon, count)
				end,
				hl = { fg = colors.red },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and (" %s %s"):format(self.modified_icon, count)
				end,
				hl = { fg = colors.orange },
			},
			Space,
		}

		local LSPActive = {
			condition = function()
				return conditions.hide_in_width() and conditions.lsp_attached()
			end,
			update = { "LspAttach", "LspDetach", "WinEnter" },
			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("LspInfo")
					end, 100)
				end,
				name = "heirline_LSP",
			},
			{
				condition = function()
					return conditions.hide_in_width() and conditions.lsp_attached()
				end,
				provider = icons.separators.vert_thick,
				hl = { fg = colors.magenta, bg = colors.bg_dark },
			},
			{
				provider = function()
					local names = {}
					for _, server in pairs(vim.lsp.get_active_clients()) do
						if server.name ~= "null-ls" then
							table.insert(names, server.name)
						end
					end

					if #names == 0 then
						return ""
					end

					return (" " .. icons.lsp .. " [%s] "):format((table.concat(names, " / ")))
				end,
				hl = { bg = colors.bg_dark, fg = colors.magenta, bold = true, italic = false },
			},
		}

		local Ruler = {
			provider = " %7(%l/%3L%):%2c ",
			condition = function()
				return conditions.buffer_not_empty() and conditions.hide_in_width()
			end,
		}

		local ScrollBar = {
			static = {
				sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
				-- Another variant, because the more choice the better.
				-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
			},
			provider = function(self)
				local curr_line = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
				return string.rep(self.sbar[i], 2)
			end,
			condition = function()
				return conditions.buffer_not_empty() and conditions.hide_in_width()
			end,
		}

		local FilePosition = utils.insert(
			{
				condition = function()
					return conditions.buffer_not_empty() and conditions.hide_in_width()
				end,
				provider = icons.separators.vert_thick,
				hl = { bg = colors.bg_dark, fg = colors.blue },
			},
			{
				condition = function()
					return conditions.buffer_not_empty() and conditions.hide_in_width()
				end,
				provider = " " .. icons.files.ruler,
				hl = { bg = colors.bg_dark, fg = colors.blue },
			},
			utils.insert({ hl = { bg = colors.bg_dark, fg = colors.blue, bold = true, italic = false } }, Ruler),
			utils.insert({ hl = { bg = colors.bg_dark, fg = colors.blue, bold = true, italic = false } }, ScrollBar)
		)

		return {
			opts = {
				disable_winbar_cb = function(args) -- We do this to avoid showing it on the greeter.
					local is_disabled = not require("heirline-components.buffer").is_valid(args.buf)
						or lib.condition.buffer_matches({
							buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
							filetype = { "NvimTree", "neo%-tree", "alpha", "Outline", "aerial" },
						}, args.buf)
					return is_disabled
				end,
			},
			statusline = {
				ViMode,
				FileNameBlock,
				Git,
				Align,
				LSPActive,
				FilePosition,
			},
			tabline = { -- UI upper bar
				lib.component.tabline_conditional_padding(),
				lib.component.tabline_buffers(),
				lib.component.fill({ hl = { bg = colors.bg_dark } }),
				lib.component.tabline_tabpages(),
			},
			winbar = { -- UI breadcrumbs bar
				init = function(self)
					self.bufnr = vim.api.nvim_get_current_buf()
				end,
				fallthrough = false,
				-- Winbar for terminal, neotree, and aerial.
				{
					condition = function()
						return not lib.condition.is_active()
					end,
					{
						lib.component.neotree(),
						lib.component.compiler_play(),
						lib.component.fill(),
						lib.component.compiler_build_type(),
						lib.component.compiler_redo(),
						lib.component.aerial(),
					},
				},
				-- Regular winbar
				{
					lib.component.neotree(),
					lib.component.compiler_play(),
					lib.component.fill(),
					lib.component.breadcrumbs(),
					lib.component.fill(),
					lib.component.compiler_redo(),
					lib.component.aerial(),
				},
			},
		}
	end,
	config = function(_, opts)
		local heirline = require("heirline")
		local heirline_components = require("heirline-components.all")

		-- Setup
		heirline_components.init.subscribe_to_events()
		heirline.load_colors(heirline_components.hl.get_colors())
		heirline.setup(opts)
	end,
}
