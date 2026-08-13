 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131314',
    base01 = '#1f2020',
    base02 = '#2a2a2b',
    base03 = '#8e9195',
    base04 = '#c4c7cb',
    base05 = '#e4e2e2',
    base06 = '#e4e2e2',
    base07 = '#e4e2e2',
    base08 = '#ffb4ab',
    base09 = '#d3c1d3',
    base0A = '#c3c7cd',
    base0B = '#bbc8d5',
    base0C = '#d3c1d3',
    base0D = '#bbc8d5',
    base0E = '#c3c7cd',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e4e2e2',          bg = '#131314' })
  hi('TelescopeBorder',         { fg = '#8e9195',             bg = '#131314' })
  hi('TelescopePromptNormal',   { fg = '#e4e2e2',          bg = '#131314' })
  hi('TelescopePromptBorder',   { fg = '#8e9195',             bg = '#131314' })
  hi('TelescopePromptPrefix',   { fg = '#bbc8d5',             bg = '#131314' })
  hi('TelescopePromptCounter',  { fg = '#c4c7cb',  bg = '#131314' })
  hi('TelescopePromptTitle',    { fg = '#131314',             bg = '#bbc8d5' })
  hi('TelescopePreviewTitle',   { fg = '#131314',             bg = '#c3c7cd' })
  hi('TelescopeResultsTitle',   { fg = '#131314',             bg = '#d3c1d3' })
  hi('TelescopeSelection',      { fg = '#e4e2e2',          bg = '#2a2a2b' })
  hi('TelescopeSelectionCaret', { fg = '#bbc8d5',             bg = '#2a2a2b' })
  hi('TelescopeMatching',       { fg = '#bbc8d5',             bold = true })
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
