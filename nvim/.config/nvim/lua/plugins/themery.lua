return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "aether",
        "catppuccin-mocha",
        "nord",
        "kanagawa",
        "onedark_dark",
        "yorumi",
        "rose-pine",
        "poimandres",
        "tokyodark",
      },
      livePreview = true,
    })

    -- Keybinding: <leader>th
    vim.keymap.set("n", "<leader>th", "<cmd>Themery<CR>", {
      desc = "Open Themery",
    })
  end,
}
