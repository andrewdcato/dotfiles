local installed, tabline = pcall(require, "tabby.tabline")
if not installed then
	return
end

vim.o.showtabline = 2

tabline.use_preset("active_wins_at_tail", {})
