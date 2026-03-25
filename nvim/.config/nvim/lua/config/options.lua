-- lua/config/options.lua
if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 20
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- transparency

  -- vim.g.neovide_normal_opacity = 1.0

  -- cursor
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_vfx_mode = "ripple" -- "", "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"

  -- font (set this in options.lua too)
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h9"
end

vim.g.mapleader = " "
vim.opt.relativenumber = true

vim.opt.guicursor = ""

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.g.lazyvim_colorscheme = "none"
