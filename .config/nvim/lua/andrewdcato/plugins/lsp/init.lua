local installed, _ = pcall(require, "lspconfig")
if not installed then
  return
end

require("andrewdcato.plugins.lsp.mason")
require("andrewdcato.plugins.lsp.handlers").setup()
require("andrewdcato.plugins.lsp.null-ls")
