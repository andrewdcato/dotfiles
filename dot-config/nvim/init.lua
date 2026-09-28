-- Map leader to a space
vim.g.mapleader = " "

-- Core options
require("cato.config.options")

-- Autocommands
require("cato.config.autocommands")

-- Bootstrap lazy.nvim if it is missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim config
require("cato.core.lazy")
