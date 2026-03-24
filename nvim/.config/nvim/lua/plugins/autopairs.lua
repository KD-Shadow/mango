-- lua/custom/plugins/autopairs.lua
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- enable treesitter integration
      enable_check_bracket_line = true,
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")

      -- Auto-expand HTML/ASTRO tags on Enter
      npairs.add_rules({
        Rule("<", ">", "html")
          :with_pair(ts_conds.is_ts_node({ "tag_name" }))
          :with_move(function(opts)
            return opts.prev_char:match(".%>") ~= nil
          end)
          :use_key("<CR>"),
      })
    end,
  },
}
