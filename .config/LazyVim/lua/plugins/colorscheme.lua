local custom_higlights = function(colors)
  return {
    NotifyBackground = { bg = "#000000" },
    TabLine = { bg = colors.mantle, fg = colors.text },
    -- git-conflict
    DiffText = { bg = colors.rosewater, fg = colors.mantle },
    DiffAdd = { bg = colors.teal, fg = colors.mantle },
    -- header and footer of feline
    UserTLHead = { bg = colors.blue, fg = colors.mantle },
    UserTlHeadSep = { bg = colors.mantle, fg = colors.blue },
    -- active tab
    UserTLActive = { bg = colors.sky, fg = colors.mantle },
    UserTlActiveSepL = { bg = colors.sky, fg = colors.mantle },
    UserTlActiveSepR = { bg = colors.mantle, fg = colors.sky },
    -- inactive tab
    UserTLInactive = { bg = colors.surface1, fg = colors.crust },
    UserTLInactiveSepL = { bg = colors.surface1, fg = colors.mantle },
    UserTLInactiveSepR = { bg = colors.mantle, fg = colors.surface1 },
    -- active window
    UserTLTopWin = { bg = colors.sapphire, fg = colors.mantle },
    UserTLTopWinL = { bg = colors.sapphire, fg = colors.mantle },
    UserTLTopWinR = { bg = colors.mantle, fg = colors.sapphire },
    -- inactive window(s)
    UserTLWin = { bg = colors.surface1, fg = colors.sapphire },
    UserTLWinL = { bg = colors.surface1, fg = colors.mantle },
    UserTLWinR = { bg = colors.mantle, fg = colors.surface1 },
  }
end

return {
  -- add catppuccin
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- load theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "catppuccin",
    opts = {
      transparent_background = true,
      custom_highlights = custom_higlights,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "italic" },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}
