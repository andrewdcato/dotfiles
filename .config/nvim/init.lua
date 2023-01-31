-- Packer config
require("andrewdcato.plugins")

-- Core options
require("andrewdcato.core.colors")
require("andrewdcato.core.options")
require("andrewdcato.core.keymaps")

-- Plugins
require("andrewdcato.plugins.theme")
require("andrewdcato.plugins.nvim-dap")
require("andrewdcato.plugins.nvim-cmp")
require("andrewdcato.plugins.lsp")
require("andrewdcato.plugins.lualine")
require("andrewdcato.plugins.bufferline")
require("andrewdcato.plugins.alpha")

-- Autocommands
require("andrewdcato.core.autocommands")
