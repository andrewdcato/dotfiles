local filetypes = {
	"astro",
	"htmlangular",
	"javascript",
	"javascript.jsx",
	"javascriptreact",
	"svelte",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
	"vue",
}

return {
	filetypes = filetypes,
	settings = {
		packageManager = "npm",
		validate = filetypes,
		probe = filetypes,
		workingDirectories = { mode = "auto" },
		experimental = {
			useFlatConfig = true,
		},
	},
}
