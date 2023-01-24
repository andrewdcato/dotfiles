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

-- have packer use a floating window instead of sidebar
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({
				border = "rounded",
				style = "minimal",
			})
		end,
	},
})

return packer.startup(function(use)
	-- Packer is magic and can manage itself
	use("wbthomason/packer.nvim")

	-- Funcs needed by many plugins
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	-- Theming
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
	use("kyazdani42/nvim-web-devicons")
	use("ellisonleao/gruvbox.nvim")
	use("EdenEast/nightfox.nvim")
	use({ "mvllow/modes.nvim", tag = "v0.2.0" })
	use("SmiteshP/nvim-navic")
	use("goolord/alpha-nvim")

	-- Statusline
	use("nanozuki/tabby.nvim")
	use("feline-nvim/feline.nvim")
	use("nvim-lualine/lualine.nvim")

	-- Git plugins
	use("f-person/git-blame.nvim") -- inline git blame
	use("kdheepak/lazygit.nvim")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- General workflow
	use("nvim-tree/nvim-tree.lua")
	use("numToStr/Comment.nvim")
	use("folke/which-key.nvim")
	use("windwp/nvim-autopairs")
	use("norcalli/nvim-colorizer.lua")

	-- Telescope
	use("nvim-telescope/telescope-packer.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- improves sorting perf
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })

	-- LSP and Formatting
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "williamboman/mason.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "RRethy/vim-illuminate" })

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- Debugger
	use("mfussenegger/nvim-dap")
	use("mxsdev/nvim-dap-vscode-js")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npm run compile",
		tag = "v1.74.1", -- you *must* specify this tag; newer versions have breaking bugs
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
