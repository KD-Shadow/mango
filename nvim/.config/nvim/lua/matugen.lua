 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0a0a12',
    base01 = '#14141e',
    base02 = '#1c1c2a',
    base03 = '#5b5b75',
    base04 = '#f2eadf',
    base05 = '#e4ded2',
    base06 = '#e4ded2',
    base07 = '#e4ded2',
    base08 = '#c25b5b',
    base09 = '#9a7398',
    base0A = '#8baa82',
    base0B = '#8b2e2e',
    base0C = '#e996e4',
    base0D = '#e99696',
    base0E = '#a8e996',
    base0F = '#561515',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e4ded2',          bg = '#0a0a12' })
  hi('TelescopeBorder',         { fg = '#5b5b75',             bg = '#0a0a12' })
  hi('TelescopePromptNormal',   { fg = '#e4ded2',          bg = '#0a0a12' })
  hi('TelescopePromptBorder',   { fg = '#5b5b75',             bg = '#0a0a12' })
  hi('TelescopePromptPrefix',   { fg = '#8b2e2e',             bg = '#0a0a12' })
  hi('TelescopePromptCounter',  { fg = '#f2eadf',  bg = '#0a0a12' })
  hi('TelescopePromptTitle',    { fg = '#0a0a12',             bg = '#8b2e2e' })
  hi('TelescopePreviewTitle',   { fg = '#0a0a12',             bg = '#8baa82' })
  hi('TelescopeResultsTitle',   { fg = '#0a0a12',             bg = '#9a7398' })
  hi('TelescopeSelection',      { fg = '#e4ded2',          bg = '#1c1c2a' })
  hi('TelescopeSelectionCaret', { fg = '#8b2e2e',             bg = '#1c1c2a' })
  hi('TelescopeMatching',       { fg = '#8b2e2e',             bold = true })
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
