local opt = vim.opt
local cmd = vim.cmd

-- Text Config
opt.guifont = { "JetBrainsMono Nerd Font", "h14" }
opt.termguicolors = true

-- Blinking Cursor
opt.guicursor = "a:block-Cursor"		-- block cursor in all modes
opt.guicursor = "i-v:blinkon10"			-- blink the cursor in insert or visual mode

-- Gruvbox config
-- local gruvbox_installed, gruvbox = pcall(require, "gruvbox")
-- if not gruvbox_installed then
-- 	return
-- end
--
-- gruvbox.setup({
-- 	inverse = true,
-- 	contrast = "hard",
-- 	transparent_mode = true,
-- })
--
-- cmd([[colorscheme gruvbox]])

-- nightfox config
local installed, nightfox = pcall(require, "nightfox")
if not installed then
  return
end

nightfox.setup({
  options = {
    transparent = true,
    styes = {
      strings = "italic,bold",
      comments = 'italic'
    }
  }
})

cmd('colorscheme nightfox')
