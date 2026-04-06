return {
  {
    "RRethy/base16-nvim",
    config = function()
      require("matugen").setup()
    end,
  },
  {
    "AvengeMedia/base46",
    lazy = false,
    priority = 1000,
    config = function()
      require("matugen").setup()
    end,
    opts = {
      hl_override = {
        -- Keywords: bold + italic
        ["@keyword"] = { bold = true, italic = true },
        ["@keyword.function"] = { bold = true, italic = true },
        ["@keyword.return"] = { bold = true, italic = true },
        ["@keyword.operator"] = { bold = true },
        ["@conditional"] = { bold = true, italic = true },
        ["@repeat"] = { bold = true, italic = true },

        -- Functions: bold
        ["@function"] = { bold = true },
        ["@function.builtin"] = { bold = true },
        ["@function.call"] = { bold = true },
        ["@method"] = { bold = true },
        ["@method.call"] = { bold = true },
        ["@constructor"] = { bold = true },

        -- Types: bold
        ["@type"] = { bold = true },
        ["@type.builtin"] = { bold = true },

        -- Constants: bold
        ["@constant"] = { bold = true },
        ["@constant.builtin"] = { bold = true },

        -- Comments: italic
        ["@comment"] = { italic = true },
        Comment = { italic = true },
      },
    },
  },
}
