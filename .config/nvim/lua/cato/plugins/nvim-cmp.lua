return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- snippet engine
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-vsnip",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"hrsh7th/vim-vsnip",
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"rafamadriz/friendly-snippets", -- useful snippets
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"windwp/nvim-autopairs",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		require("luasnip.loaders.from_vscode").lazy_load()

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		local border_opts = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		}

		local keymaps = {
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			-- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-y>"] = cmp.config.disable,
			["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = keymaps,
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]

						return vim_item
					end,
				}),
			},
			sources = {
				{ name = "path", priority = 250 }, -- file paths
				{ name = "nvim_lsp", priority = 1000, keyword_length = 3 }, -- from language server
				{ name = "nvim_lsp_signature_help", priority = 900 }, -- display function signatures with current parameter emphasized
				{ name = "nvim_lua", priority = 750, keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
				{ name = "buffer", priority = 500, keyword_length = 2 }, -- source current buffer
				{ name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
				{ name = "calc" }, -- source for math calculation
			},
			duplicates = {
				nvim_lsp = 1,
				luasnip = 1,
				cmp_tabnine = 1,
				buffer = 1,
				path = 1,
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				completion = cmp.config.window.bordered(border_opts),
				documentation = cmp.config.window.bordered(border_opts),
			},
			experimental = {
				native_menu = false,
				ghost_text = true,
			},
		})

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			sources = cmp.config.sources({
				{ name = "buffer" },
			}),
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
