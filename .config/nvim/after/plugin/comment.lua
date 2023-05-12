local comment_installed, comment = pcall(require, "Comment")
if not comment_installed then
	return
end

comment.setup()
