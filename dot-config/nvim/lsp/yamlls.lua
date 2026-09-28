return {
	filetypes = { "yaml", "yaml.ansible", "yaml.docker-compose" },
	settings = {
		redhat = { telementry = { enabled = false } },
		yaml = {
			format = "enable",
			keyOrdering = false,
			schemas = {
				["https://api.bitbucket.org/schemas/pipelines-configuration"] = "bitbucket-pipelines.*",
				["https://json.schemastore.org/github-action.json"] = ".github/actions/*",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.*",
			},
		},
	},
}
