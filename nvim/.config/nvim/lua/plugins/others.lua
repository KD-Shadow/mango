return {
  {
    "declancm/cinnamon.nvim",
    version = "*", -- use latest release
    opts = {
      -- change default options here
    },
  },
  { "nvim-mini/mini.animate", version = false },
  {
    "smjonas/inc-rename.nvim",
    lazy = false,
    opts = {},
    vim.keymap.set("n", "<leader>rn", ":IncRename "),
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
  {
    "atiladefreitas/dooing",
    lazy = true,
    enabled = false,
    config = function()
      require("dooing").setup({
        window = {
          border = "rounded",
          position = "center",
        },
      })
    end,
  },
}
