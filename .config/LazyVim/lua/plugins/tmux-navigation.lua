return {
  { "alexgergh/nvim-tmux-navigation", name = "tmux-nav", prioritiy = 1000 },

  {
    "tmux-nav",
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      },
    },
  },
}
