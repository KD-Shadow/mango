 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#121212',
    base01 = '#181616',
    base02 = '#232020',
    base03 = '#6d5d5d',
    base04 = '#c4bcbc',
    base05 = '#e8e0e0',
    base06 = '#e8e0e0',
    base07 = '#e8e0e0',
    base08 = '#d64545',
    base09 = '#7a0000',
    base0A = '#c8962a',
    base0B = '#990000',
    base0C = '#ff8080',
    base0D = '#ff8080',
    base0E = '#e9cf96',
    base0F = '#5d0b0b',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e8e0e0',          bg = '#121212' })
  hi('TelescopeBorder',         { fg = '#6d5d5d',             bg = '#121212' })
  hi('TelescopePromptNormal',   { fg = '#e8e0e0',          bg = '#121212' })
  hi('TelescopePromptBorder',   { fg = '#6d5d5d',             bg = '#121212' })
  hi('TelescopePromptPrefix',   { fg = '#990000',             bg = '#121212' })
  hi('TelescopePromptCounter',  { fg = '#c4bcbc',  bg = '#121212' })
  hi('TelescopePromptTitle',    { fg = '#121212',             bg = '#990000' })
  hi('TelescopePreviewTitle',   { fg = '#121212',             bg = '#c8962a' })
  hi('TelescopeResultsTitle',   { fg = '#121212',             bg = '#7a0000' })
  hi('TelescopeSelection',      { fg = '#e8e0e0',          bg = '#232020' })
  hi('TelescopeSelectionCaret', { fg = '#990000',             bg = '#232020' })
  hi('TelescopeMatching',       { fg = '#990000',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
