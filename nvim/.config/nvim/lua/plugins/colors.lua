return {
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        highlights = {
          Comment = { italic = true },
          Keyword = { bold = true, italic = true },
          ["@keyword"] = { bold = true, italic = true },
          Function = { bold = true, italic = true },
          ["@function"] = { bold = true, italic = true },
          ["@function.call"] = { bold = true, italic = true },
          Todo = {
            bold = true,
            italic = true,
            fg = "#ffffff",
            bg = "#ff5f5f",
          },

          ["@comment.todo"] = {
            bold = true,
            italic = true,
            fg = "#ffffff",
            bg = "#ff5f5f",
          },
        },
      })
    end,
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "yorumicolors/yorumi.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- make sure it loads before other plugins
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
    },
    config = function(_, opts) end,
  },
}
