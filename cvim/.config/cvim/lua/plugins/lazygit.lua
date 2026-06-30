return {
  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
      { "<leader>gc", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Commits" },
    },
  },

  -- Enhanced Gitsigns (LazyVim already includes this)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Show blame on current line
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
      },
    },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Line Blame" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
      { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev Hunk" },
    },
  },
}
