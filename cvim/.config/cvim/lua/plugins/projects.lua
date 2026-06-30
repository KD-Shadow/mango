return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "Cargo.toml", "package.json", "pyproject.toml", ".python-version" },
        silent_chdir = true,
        scope_chdir = "global",
      })
    end,
    keys = {
      {
        "<leader>fp",
        function()
          local history = require("project_nvim").get_recent_projects()
          Snacks.picker.pick({
            title = "Projects",
            items = vim.tbl_map(function(p)
              return { text = p, file = p }
            end, history),
            format = "file",
            confirm = function(picker, item)
              picker:close()
              vim.cmd.cd(item.text)
              Snacks.picker.files({ cwd = item.text })
            end,
          })
        end,
        desc = "Find Projects",
      },
    },
  },
}
