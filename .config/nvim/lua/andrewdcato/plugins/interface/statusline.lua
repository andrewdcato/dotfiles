-- Blatantly borrowed from github.com/thanhvule0310 - mostly like the aesthetic / info shown in his dots but need to tweak further...
return {
	"rebelot/heirline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "neovim/nvim-lspconfig" },
	config = function()
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local colors = require("catppuccin.palettes").get_palette()
		local icons = require("andrewdcato.util").icons

		conditions.buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end

		conditions.hide_in_width = function(size)
			return vim.api.nvim_get_option("columns") > (size or 140)
		end

		local Align = { provider = "%=", hl = { bg = colors.mantle } }
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
					["!"] = colors.maroon,
					["R"] = colors.flamingo,
					["Rc"] = colors.flamingo,
					["Rv"] = colors.rosewater,
					["Rx"] = colors.flamingo,
					["S"] = colors.teal,
					["V"] = colors.lavender,
					["Vs"] = colors.lavender,
					["c"] = colors.peach,
					["ce"] = colors.peach,
					["cv"] = colors.peach,
					["i"] = colors.green,
					["ic"] = colors.green,
					["ix"] = colors.green,
					["n"] = colors.blue,
					["niI"] = colors.blue,
					["niR"] = colors.blue,
					["niV"] = colors.blue,
					["no"] = colors.pink,
					["no"] = colors.pink,
					["noV"] = colors.pink,
					["nov"] = colors.pink,
					["nt"] = colors.red,
					["null"] = colors.pink,
					["r"] = colors.teal,
					["r?"] = colors.maroon,
					["rm"] = colors.sky,
					["s"] = colors.teal,
					["t"] = colors.red,
					["v"] = colors.mauve,
					["vs"] = colors.mauve,
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
				return { bg = self.mode_colors[mode], fg = colors.base, bold = true }
			end,
			update = { "ModeChanged" },
		}

		local FileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
			condition = conditions.buffer_not_empty,
			hl = { bg = colors.base, fg = colors.subtext1 },
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
			hl = { fg = colors.subtext1, bold = true },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = " ● ",
				hl = { fg = colors.lavender },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "",
				hl = { fg = colors.red },
			},
		}

		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					return { fg = colors.text, bold = true, force = true }
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
				hl = { fg = colors.sapphire },
			},
			{
				provider = function(self)
					return self.hints > 0 and ("%s%s "):format(self.hint_icon, self.hints)
				end,
				hl = { fg = colors.sky },
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
				hl = { bg = colors.mantle, fg = colors.base },
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
			hl = { bg = colors.mantle, fg = colors.mauve },
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
				hl = { fg = colors.peach },
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
			{ provider = icons.separators.rounded_left, hl = { bg = colors.base, fg = colors.sapphire } },
			{ provider = icons.lsp, hl = { bg = colors.sapphire, fg = colors.base } },
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

					return (" [%s] "):format((table.concat(names, " / ")))
				end,
				hl = { bg = colors.surface0, fg = colors.subtext1, bold = true, italic = false },
			},
		}

		local FileFormat = {
			provider = function()
				local fmt = vim.bo.fileformat
				if fmt == "unix" then
					return " LF "
				elseif fmt == "mac" then
					return " CR "
				else
					return " CRLF "
				end
			end,
			condition = function()
				return conditions.buffer_not_empty() and conditions.hide_in_width()
			end,
		}

		local FileEncoding = {
			provider = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
				return (" %s "):format(enc:upper())
			end,
			condition = function()
				return conditions.buffer_not_empty() and conditions.hide_in_width()
			end,
		}

		local FileDetails = utils.insert(
			{ provider = icons.separators.rounded_left, hl = { bg = colors.surface0, fg = colors.mauve } },
			{ provider = icons.files.details, hl = { bg = colors.mauve, fg = colors.base } },
			utils.insert(
				{ hl = { bg = colors.surface0, fg = colors.subtext1, bold = true, italic = false } },
				FileFormat,
				{ provider = icons.separators.dotted_vert },
				FileEncoding
			)
		)

		local Ruler = {
			provider = " %7(%l/%3L%):%2c %P ",
			condition = function()
				return conditions.buffer_not_empty() and conditions.hide_in_width()
			end,
		}

		local FilePosition = utils.insert(
			{ provider = icons.separators.rounded_left, hl = { bg = colors.surface0, fg = colors.blue } },
			{ provider = icons.files.ruler, hl = { bg = colors.blue, fg = colors.base } },
			utils.insert({ hl = { bg = colors.surface0, fg = colors.subtext1, bold = true, italic = false } }, Ruler)
		)

		heirline.setup({
			statusline = {
				ViMode,
				FileNameBlock,
				Git,
				Align,
				LSPActive,
				FileDetails,
				FilePosition,
			},
		})
	end,
}
