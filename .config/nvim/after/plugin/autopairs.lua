local installed, apairs = pcall(require, "nvim-autopairs")
if not installed then
	return
end

apairs.setup({
	check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
})
