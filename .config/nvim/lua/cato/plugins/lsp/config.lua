local icons = require("cato.util").icons

local servers = {
	mason = {
		"ansiblels",
		"cssls",
		"cssmodules_ls",
		"dockerls",
		"eslint",
		"html",
		"jsonls",
		"lua_ls",
		"rust_analyzer",
		"svelte",
		"tailwindcss",
		"terraformls",
		"tflint",
		"ts_ls",
		"yamlls",
		"sqlls",
	},
	tools = {
		"eslint",
		"eslint_d",
		"prettier",
		"prettierd",
		"stylua",
		"ansible-lint",
		"tflint",
		"yamllint",
	},
}

return {
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "RubixDev/mason-update-all", config = true },
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

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
				ensure_installed = servers.mason,
				automatic_installation = true,
			})

			mason_tool_installer.setup({
				ensure_installed = servers.tools,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
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

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
					border = "rounded",
				}),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
					border = "rounded",
				}),
			}

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			-- Configure on_attach function
			local km = vim.keymap
			local opts = { noremap = true, silent = true }
			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

				opts.desc = "Show LSP code actions"
				km.set("n", "<leader>la", vim.lsp.buf.code_action, opts)

				opts.desc = "Go to definition"
				km.set("n", "<leader>ld", vim.lsp.buf.definition, opts)

				opts.desc = "Go to declaration"
				km.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)

				opts.desc = "Go to implementation"
				km.set("n", "<leader>li", vim.lsp.buf.implementation, opts)

				opts.desc = "Show references"
				km.set("n", "<leader>lr", vim.lsp.buf.references, opts)

				opts.desc = "Rename"
				km.set("n", "<leader>lR", vim.lsp.buf.rename, opts)

				opts.desc = "Show signature help"
				km.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)

				opts.desc = "Go to next diagnostic"
				km.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)

				opts.desc = "Go to previous diagnostic"
				km.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_previous({buffer=0})<cr>", opts)

				opts.desc = "Show LSP Info"
				km.set("n", "<leader>lI", "<cmd>LspInfo<cr>", opts)

				opts.desc = "Show hover docs"
				km.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				km.set("n", "<leader>rs", "<cmd>LspRestart<cr>", opts) -- mapping to restart lsp if necessary

				if client.name == "ts_ls" then
					client.server_capabilities.documentFormattingProvider = false
				end

				if client.name == "lua_ls" then
					client.server_capabilities.documentFormattingProvider = false
				end

				if client.name == "yamlls" then
					client.server_capabilities.documentFormattingProvider = true
				end

				if client.name == "eslint" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
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

			-- Loop through configuration files for servers and configure them
			-- NOTE: file names need to mirror mason-lspconfigs names
			local serverOpts = {}
			for _, server in pairs(servers.mason) do
				serverOpts = {
					on_attach = on_attach,
					capabilities = capabilities,
					handlers = handlers,
				}

				server = vim.split(server, "@")[1]

				local require_ok, conf_opts = pcall(require, "cato.plugins.lsp.settings." .. server)
				if require_ok then
					serverOpts = vim.tbl_deep_extend("force", conf_opts, serverOpts)
				end

				lspconfig[server].setup(serverOpts)
			end
		end,
	},
}
