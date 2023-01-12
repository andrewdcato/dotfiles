local installed, bufferline = pcall(require, "bufferline")
if not installed then
  return
end

bufferline.setup({
  options = {
    diagnostics = "nvim-cmp",
    offsets = { 
      { 
        filetype = "NvimTree", 
        text = "File Explorer",
        text_align = "left",
        separator = true,
      } 
    },
  },
})
