return {
  -- Below for the osaka theme
  {
    "bjarneo/aether.nvim",
    name = "aether",
    priority = 1000,
    opts = {
      transparent = false,
      terminal_colors = true,
      dim_inactive = false,
      lualine_bold = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { bold = true },
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      colors = {
        base00 = "#111c18",
        base01 = "#23372B",
        base02 = "#53685B",
        base03 = "#53685B",
        base04 = "#75bbb3",
        base05 = "#C1C497",
        base06 = "#ACD4CF",
        base07 = "#ffffff",
        base08 = "#FF5345",
        base09 = "#db9f9c",
        base0A = "#E5C736",
        base0B = "#549e6a",
        base0C = "#2DD5B7",
        base0D = "#509475",
        base0E = "#D2689C",
        base0F = "#53685B",
      },
      on_colors = function(colors)
        colors.hint = colors.base0C
        colors.error = colors.base08
      end,
      on_highlights = function(hl, colors)
        hl.Comment = { fg = colors.base03, italic = true }
        hl.Function = { fg = colors.base0D, bold = true }
        hl.Keyword = { fg = colors.base0E, italic = true, bold = true }
      end,
      cache = true,
      plugins = {
        all = package.loaded.lazy == nil,
        auto = true,
      },
    },
  },

  --- For the Sh4dow theme
  -- {
  --   "bjarneo/aether.nvim",
  --   name = "aether",
  --   priority = 1000,
  --   opts = {
  --     transparent = false,
  --     terminal_colors = true,
  --     dim_inactive = false,
  --     lualine_bold = false,
  --     styles = {
  --       comments = { italic = true },
  --       keywords = { italic = true, bold = true },
  --       functions = { bold = true },
  --       variables = {},
  --       sidebars = "dark",
  --       floats = "dark",
  --     },
  --
  --     colors = {
  --       -- Monotone shades
  --       base00 = "#0E0E10",
  --       base01 = "#1A1A1D",
  --       base02 = "#232323",
  --       base03 = "#5a5a5a",
  --       base04 = "#8B8B8B",
  --       base05 = "#D6D6D6",
  --       base06 = "#e8e8e8",
  --       base07 = "#ffffff",
  --
  --       -- Accents
  --       base08 = "#D1495B",
  --       base09 = "#FF6D00",
  --       base0A = "#F77F00",
  --       base0B = "#4F772D",
  --       base0C = "#2A9D8F",
  --       base0D = "#3A86FF",
  --       base0E = "#8338EC",
  --       base0F = "#7A5C52",
  --     },
  --
  --     on_colors = function(colors)
  --       colors.hint = colors.base0C
  --       colors.error = colors.base08
  --     end,
  --     on_highlights = function(hl, colors)
  --       hl.Comment = { fg = colors.base03, italic = true }
  --       hl.Function = { fg = colors.base0D, bold = true }
  --       hl.Keyword = { fg = colors.base0E, italic = true, bold = true }
  --     end,
  --     cache = true,
  --     plugins = {
  --       all = package.loaded.lazy == nil,
  --       auto = true,
  --     },
  --   },
  -- },
}
