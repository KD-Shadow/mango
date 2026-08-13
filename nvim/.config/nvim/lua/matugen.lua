 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#161616',
    base01 = '#202020',
    base02 = '#2a2a2a',
    base03 = '#57656c',
    base04 = '#d3c6aa',
    base05 = '#d3c6aa',
    base06 = '#d3c6aa',
    base07 = '#d3c6aa',
    base08 = '#e67e80',
    base09 = '#7fbbb3',
    base0A = '#dbbc7f',
    base0B = '#a7c080',
    base0C = '#96e9de',
    base0D = '#c8e996',
    base0E = '#e9cd96',
    base0F = '#a21012',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#d3c6aa',          bg = '#161616' })
  hi('TelescopeBorder',         { fg = '#57656c',             bg = '#161616' })
  hi('TelescopePromptNormal',   { fg = '#d3c6aa',          bg = '#161616' })
  hi('TelescopePromptBorder',   { fg = '#57656c',             bg = '#161616' })
  hi('TelescopePromptPrefix',   { fg = '#a7c080',             bg = '#161616' })
  hi('TelescopePromptCounter',  { fg = '#d3c6aa',  bg = '#161616' })
  hi('TelescopePromptTitle',    { fg = '#161616',             bg = '#a7c080' })
  hi('TelescopePreviewTitle',   { fg = '#161616',             bg = '#dbbc7f' })
  hi('TelescopeResultsTitle',   { fg = '#161616',             bg = '#7fbbb3' })
  hi('TelescopeSelection',      { fg = '#d3c6aa',          bg = '#2a2a2a' })
  hi('TelescopeSelectionCaret', { fg = '#a7c080',             bg = '#2a2a2a' })
  hi('TelescopeMatching',       { fg = '#a7c080',             bold = true })
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
