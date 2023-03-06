local git_conflict_ok, git_conflict = pcall(require, "git-conflict")
if not git_conflict_ok then
	return
end

git_conflict.setup({
	default_commands = true,
	default_mappings = true,
	highlights = { incoming = "DiffText", current = "DiffAdd" },
})
