local opt = vim.opt

-- Text Config
opt.guifont = { "JetBrainsMono Nerd Font", "h14" }
opt.termguicolors = true

-- Blinking Cursor
opt.guicursor = "a:block-Cursor" -- block cursor in all modes
opt.guicursor = "i-v:blinkon10" -- blink the cursor in insert or visual mode
