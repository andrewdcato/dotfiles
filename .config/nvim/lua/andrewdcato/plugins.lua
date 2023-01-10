local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end

	return false
end

local packer_bootstrap = ensure_packer()

-- Auto-sync plugins when we save the plugins file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

local packer_installed, packer = pcall(require, "packer")
if not packer_installed then
	return
end

return packer.startup(function(use)
	-- Packer is magic and can manage itself
	use("wbthomason/packer.nvim")

  -- Funcs needed by many plugins
	use("nvim-lua/plenary.nvim")

	-- Theming
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update { with_sync = true })
		end,
	})

	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
	use("kyazdani42/nvim-web-devicons")
	use("ellisonleao/gruvbox.nvim")

	-- Statusline
	use("nvim-lualine/lualine.nvim")

	-- Git plugins
	use("f-person/git-blame.nvim")	-- inline git blame
	use("kdheepak/lazygit.nvim")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup()
		end
	})

	-- General workflow
	use("nvim-tree/nvim-tree.lua")
	use("numToStr/Comment.nvim")

	-- Fuzzy finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- improves sorting perf
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })

	if packer_boostrap then
		require("packer").sync()
	end
end)
