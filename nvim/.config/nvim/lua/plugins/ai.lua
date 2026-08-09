-- lua/plugins/minuet.lua
return {
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  config = function()
    require("minuet").setup({
      provider = "openai_compatible",
      request_timeout = 2.5,
      throttle = 1500, -- min ms between requests
      debounce = 600, -- wait for a pause before firing
      provider_options = {
        openai_compatible = {
          api_key = "OPENROUTER_API_KEY",
          end_point = "https://openrouter.ai/api/v1/chat/completions",
          model = "deepseek/deepseek-v4-flash", -- fast + cheap, good for completion
          name = "Openrouter",
          optional = {
            max_tokens = 56,
            top_p = 0.9,
            reasoning = { effort = "none" }, -- skip "thinking", cuts latency
          },
        },
      },
      virtualtext = {
        -- auto_trigger_ft = {}, -- nothing fires automatically — you trigger it
        keymap = {
          accept = "<A-A>", -- accept the whole suggestion
          accept_line = "<A-a>", -- accept just one line
          next = "<A-]>", -- fetch a suggestion / cycle forward
          prev = "<A-[>", -- cycle backward
          dismiss = "<A-e>", -- dismiss
        },
      },
    })
  end,
}
