 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131316',
    base01 = '#201f22',
    base02 = '#2a292c',
    base03 = '#928f99',
    base04 = '#c8c5cf',
    base05 = '#e5e1e5',
    base06 = '#e5e1e5',
    base07 = '#e5e1e5',
    base08 = '#ffb4ab',
    base09 = '#ecb8d6',
    base0A = '#c7c4d8',
    base0B = '#c4c2ef',
    base0C = '#ecb8d6',
    base0D = '#c4c2ef',
    base0E = '#c7c4d8',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e5e1e5',          bg = '#131316' })
  hi('TelescopeBorder',         { fg = '#928f99',             bg = '#131316' })
  hi('TelescopePromptNormal',   { fg = '#e5e1e5',          bg = '#131316' })
  hi('TelescopePromptBorder',   { fg = '#928f99',             bg = '#131316' })
  hi('TelescopePromptPrefix',   { fg = '#c4c2ef',             bg = '#131316' })
  hi('TelescopePromptCounter',  { fg = '#c8c5cf',  bg = '#131316' })
  hi('TelescopePromptTitle',    { fg = '#131316',             bg = '#c4c2ef' })
  hi('TelescopePreviewTitle',   { fg = '#131316',             bg = '#c7c4d8' })
  hi('TelescopeResultsTitle',   { fg = '#131316',             bg = '#ecb8d6' })
  hi('TelescopeSelection',      { fg = '#e5e1e5',          bg = '#2a292c' })
  hi('TelescopeSelectionCaret', { fg = '#c4c2ef',             bg = '#2a292c' })
  hi('TelescopeMatching',       { fg = '#c4c2ef',             bold = true })
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
