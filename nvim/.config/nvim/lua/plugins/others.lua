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
