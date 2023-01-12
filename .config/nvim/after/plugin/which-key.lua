local installed, whichkey = pcall(require, "which-key")
if not installed then
	return
end

whichkey.setup()
