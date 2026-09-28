return {
	filetypes = {
		"css",
		"html",
		"javascript.jsx",
		"javascriptreact",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"svelte",
		"typescript.tsx",
		"typescriptreact",
	},
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
				},
			},
		},
	},
}
