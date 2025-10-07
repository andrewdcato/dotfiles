local default_schemas = nil
local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
if status_ok then
	default_schemas = jsonls_settings.get_default_schemas()
end

local schemas = {
	{
		description = "TypeScript compiler configuration file",
		fileMatch = {
			"tsconfig.json",
			"tsconfig.*.json",
		},
		url = "https://json.schemastore.org/tsconfig.json",
	},
	{
		description = "Lerna config",
		fileMatch = { "lerna.json" },
		url = "https://json.schemastore.org/lerna.json",
	},
	{
		description = "Babel configuration",
		fileMatch = {
			".babelrc.json",
			".babelrc",
			"babel.config.json",
		},
		url = "https://json.schemastore.org/babelrc.json",
	},
	{
		description = "ESLint config",
		fileMatch = {
			".eslintrc.json",
			".eslintrc",
		},
		url = "https://json.schemastore.org/eslintrc.json",
	},
	{
		description = "Bucklescript config",
		fileMatch = { "bsconfig.json" },
		url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
	},
	{
		description = "Prettier config",
		fileMatch = {
			".prettierrc",
			".prettierrc.json",
			"prettier.config.json",
		},
		url = "https://json.schemastore.org/prettierrc",
	},
	{
		description = "Vercel Now config",
		fileMatch = { "now.json" },
		url = "https://json.schemastore.org/now",
	},
	{
		description = "Stylelint config",
		fileMatch = {
			".stylelintrc",
			".stylelintrc.json",
			"stylelint.config.json",
		},
		url = "https://json.schemastore.org/stylelintrc",
	},
	{
		description = "Configuration file as an alternative for configuring your repository in the settings page.",
		fileMatch = {
			".codeclimate.json",
		},
		url = "https://json.schemastore.org/codeclimate.json",
	},
	{
		description = "LLVM compilation database",
		fileMatch = {
			"compile_commands.json",
		},
		url = "https://json.schemastore.org/compile-commands.json",
	},
	{
		description = "Config file for Command Task Runner",
		fileMatch = {
			"commands.json",
		},
		url = "https://json.schemastore.org/commands.json",
	},
	{
		description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
		fileMatch = {
			"*.cf.json",
			"cloudformation.json",
		},
		url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
	},
	{
		description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
		fileMatch = {
			"serverless.template",
			"*.sam.json",
			"sam.json",
		},
		url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
	},
	{
		description = "Packer template JSON configuration",
		fileMatch = {
			"packer.json",
		},
		url = "https://json.schemastore.org/packer.json",
	},
	{
		description = "NPM configuration file",
		fileMatch = {
			"package.json",
			"package-lock.json",
		},
		url = "https://json.schemastore.org/package.json",
	},
	{
		description = "LazyGit config file",
		fileMatch = { "**/lazygit/config.yml " },
		url = "https://json.schemastore.org/lazygit.json",
	},
}

local function extend(tab1, tab2)
	for _, value in ipairs(tab2 or {}) do
		table.insert(tab1, value)
	end
	return tab1
end

local extended_schemas = extend(schemas, default_schemas)

local opts = {
	settings = {
		json = {
			schemas = extended_schemas,
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	},
}

return opts
