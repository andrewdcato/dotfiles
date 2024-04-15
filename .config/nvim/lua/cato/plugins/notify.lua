return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")

		notify.setup({
			background_color = "#000000",
			render = "compact",
			fps = 60,
		})

		vim.notify = notify
	end,
}
