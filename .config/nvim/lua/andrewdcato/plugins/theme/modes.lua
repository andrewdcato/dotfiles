local installed, modes = pcall(require, "modes")
if not installed then
	return
end

modes.setup()
