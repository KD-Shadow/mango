return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>e", false },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({})
        end,
        desc = "Grep",
      },
      -- Open git log in vertical view
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log({
            finder = "git_log",
            format = "git_log",
            preview = "git_show",
            confirm = "git_checkout",
            layout = "vertical",
          })
        end,
        desc = "Git Log",
      },

      -- -- List git branches with Snacks_picker to quickly switch to a new branch
      {
        "<leader>bb>",
        function()
          Snacks.picker.git_branches({
            layout = "select",
          })
        end,
        desc = "Branches",
      },

      {
        "<leader>k",
        function()
          Snacks.picker.keymaps({
            layout = "vertical",
          })
        end,
        desc = "Keymaps",
      },
      -- File picker
      {
        "<leader><space>",
        function()
          Snacks.picker.files({
            finder = "files",
            format = "file",
            show_empty = true,
            supports_live = true,
            hidden = true,
            ignored = true,
            -- In case you want to override the layout for this keymap
            -- layout = "vscode",
          })
        end,
        desc = "Find Files",
      },
      -- Navigate my buffers
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers({
            -- I always want my buffers picker to start in normal mode
            on_show = function()
              vim.cmd.stopinsert()
            end,
            finder = "buffers",
            format = "buffer",
            hidden = false,
            unloaded = true,
            current = true,
            sort_lastused = true,
            win = {
              input = {
                keys = {
                  ["d"] = "bufdelete",
                },
              },
              list = { keys = { ["d"] = "bufdelete" } },
            },
            -- In case you want to override the layout for this keymap
            -- layout = "ivy",
          })
        end,
        desc = "[P]Snacks picker buffers",
      },
    },
    opts = {
      scroll = {},
      quickfile = {},
      indent = {
        enabled = false,
      },
      -- Documentation for the picker
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      picker = {
        transform = function(item)
          if not item.file then
            return item
          end
          if item.file:match("lazyvim/lua/config/keymaps%.lua") then
            item.score_add = (item.score_add or 0) - 30
          end
          return item
        end,
        debug = {
          scores = false, -- show scores in the list
        },
        layout = {
          -- preset="ivy",
          -- preset = "vscode",
          -- preset = "left",
          -- preset = "right",
          preset = "dropdown",
          cycle = false,
        },
        layouts = {
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
          --
          vertical = {
            layout = {
              backdrop = false,
              width = 0.8,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
        matcher = {
          frecency = true,
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
        },
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
            truncate = 80,
          },
        },
      },
      lazygit = {
        theme = {
          selectedLineBgColor = { bg = "CursorLine" },
        },
        win = {
          width = 0,
          height = 0,
        },
      },
      notifier = {
        enabled = true,
        top_down = false, -- place notifications from top to bottom
      },
      styles = {
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
      image = {
        enabled = true,
        doc = {
          inline = vim.g.neovim_mode == "skitty" and true or false,
          float = true,
          max_width = vim.g.neovim_mode == "skitty" and 5 or 60,
          max_height = vim.g.neovim_mode == "skitty" and 2.5 or 30,
        },
      },
      dashboard = {
        -- enabled = vim.g.scrollback_mode ~= "neobean", -- Disable for scrollback_mode
        preset = {
          keys = {
            -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            -- {
            --   icon = " ",
            --   key = "c",
            --   desc = "Config",
            --   action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            -- },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "<esc>", desc = "Quit", action = ":qa" },
          },
          -- Font Name: ANSI Shadow
          -- https://patorjk.com/software/taag
          header = [[
   _____ __  __ __ __   ____   ____  _      __
  / ___// / / // // /  / __ \ / __ \| | /| / /
  \__ \/ /_/ // // /_ / / / // / / /| |/ |/ / 
 ___/ / __  //__  __// /_/ // /_/ / |  /|  /  
/____/_/ /_/   /_/  /_____/ \____/  |_/ |_/   
]],
        },
      },
    },
  },
}
