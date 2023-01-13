local installed, feline = pcall(require, "feline")
if not installed then
  return
end

feline.setup()
