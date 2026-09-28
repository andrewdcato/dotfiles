return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "InsertEnter" },
	---@module "ibl"
	---@type ibl.config
	opts = {
		show_current_context = true,
		show_current_context_start = true,
	},
}
