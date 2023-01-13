local installed, colorizer = pcall(require, 'nvim-colorizer')
if not installed then
  return
end

colorizer.setup()
