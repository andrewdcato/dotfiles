---@class obsidian.config
---@field completion table
---@field workspaces table[]
---@field templates table
---@field callbacks table
---@field note_frontmatter_func function

---@class obsidian.Client

---@class obsidian.Note
---@field bufnr number

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- TODO: filter down to only markdown files in identified vaults...
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- see below for full list of optional dependencies 👇
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		completion = {
			nvim_cmp = false,
			blink = true,
		},
		note_frontmatter_func = function(note)
			return note.frontmatter
		end,
		workspaces = {
			{
				name = "Loanspark",
				path = "~/Documents/Loanspark/",
			},
			-- TODO: configure for other vaults on personal machine...
		},
		-- TODO: configure date and time formats
		templates = {
			folder = "99_Extras/Templates",
			date_format = "%Y-%m-%d-%a",
			time_format = "%H:%M",
		},
		callbacks = {
			-- Runs anytime you leave the buffer for a note.
			---@param client obsidian.Client
			---@param note obsidian.Note
			---@diagnostic disable-next-line: unused-local
			leave_note = function(client, note)
				vim.api.nvim_buf_call(note.bufnr or 0, function()
					vim.cmd("silent w")
				end)
			end,
		},
	},
}
