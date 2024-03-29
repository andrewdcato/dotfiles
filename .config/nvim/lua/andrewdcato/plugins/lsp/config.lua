local icons = require("andrewdcato.util").icons

local servers = {
	"ansiblels",
	"cssls",
	"cssmodules_ls",
	"dockerls",
	"html",
	"jsonls",
	"lua_ls",
	"prismals",
	"rust_analyzer",
	"svelte",
	"tailwindcss",
	"terraformls",
	"tflint",
	"tsserver",
	"yamlls",
}

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			{ "RubixDev/mason-update-all", config = true },
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_null_ls = require("mason-null-ls")

			mason.setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			})

			mason_lspconfig.setup({
				ensure_installed = servers,
				automatic_installation = true,
			})

			mason_null_ls.setup({
				ensure_installed = { "eslint_d", "prettier", "stylua" },
				automatic_installation = true,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				border = "rounded",
				symbol_in_winbar = {
					enable = false,
				},
				scroll_preview = {
					scroll_down = "<C-j>",
					scroll_up = "<C-k>",
				},
				lightbulb = {
					virtual_text = false,
				},
				ui = {
					code_action = icons.diagnostics.code_action,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvimdev/lspsaga.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"SmiteshP/nvim-navic",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Configure diagnostic symbols
			local signs = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.warn },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.info },
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			local diagnostic_config = {
				virtual_text = true, -- disable virtual text
				signs = {
					active = signs, -- show signs
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}

			vim.diagnostic.config(diagnostic_config)

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			-- Configure on_attach function
			local km = vim.keymap
			local opts = { noremap = true, silent = true }
			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

				opts.desc = "Show LSP code actions"
				-- km.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				km.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", opts)

				opts.desc = "Go to definition"
				-- km.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				km.set("n", "<leader>ld", "<cmd>Lspsaga goto_definition<cr>", opts)

				-- opts.desc = "Go to declaration"
				-- km.set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)

				-- opts.desc = "Go to implementation"
				-- km.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				opts.desc = "Show implementation"
				km.set("n", "<leader>li", "<cmd>Lspsaga finder imp<cr>", opts)

				opts.desc = "Show references"
				-- km.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				km.set("n", "<leader>lr", "<cmd>Lspsaga finder ref<cr>", opts)

				opts.desc = "Rename"
				-- km.set("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				km.set("n", "<leader>lR", "<cmd>Lspsaga rename<cr>", opts)

				opts.desc = "Show signature help"
				-- km.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				km.set("n", "<leader>ls", "<cmd>Lspsaga hover_doc<cr>", opts)

				opts.desc = "Go to next diagnostic"
				-- km.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
				km.set("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)

				opts.desc = "Go to previousdiagnostic"
				-- km.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_previous({buffer=0})<cr>", opts)
				km.set("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)

				opts.desc = "Show LSP Info"
				km.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)

				opts.desc = "Show hover docs"
				km.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)

				if client.name == "tsserver" then
					client.server_capabilities.documentFormattingProvider = false
				end

				if client.name == "lua_ls" then
					client.server_capabilities.documentFormattingProvider = false
				end

				if client.name == "yamlls" then
					client.server_capabilities.documentFormattingProvider = true
				end

				-- Attach nvim-navic to buffer's LSP instance
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, bufnr)
				end
			end

			-- Configure capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

			-- Loop through configuration files for LSP servers and configure them
			local serverOpts = {}
			for _, server in pairs(servers) do
				serverOpts = {
					on_attach = on_attach,
					capabilities = capabilities,
				}

				server = vim.split(server, "@")[1]

				local require_ok, conf_opts = pcall(require, "andrewdcato.plugins.lsp.settings." .. server)
				if require_ok then
					serverOpts = vim.tbl_deep_extend("force", conf_opts, serverOpts)
				end

				lspconfig[server].setup(serverOpts)
			end
		end,
	},
}
