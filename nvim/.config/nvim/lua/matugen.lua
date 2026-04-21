local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#131316", -- Default Background
    base01 = "#1f1f23", -- Lighter Background (status bars)
    base02 = "#2a2a2d", -- Selection Background
    base03 = "#90909a", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#c6c5d0", -- Dark Foreground (status bars)
    base05 = "#e4e1e6", -- Default Foreground
    base06 = "#e4e1e6", -- Light Foreground
    base07 = "#e4e1e6", -- Lightest Foreground
    -- Accent colors
    base08 = "#ffb4ab", -- Variables, XML Tags, Errors
    base09 = "#e4bad9", -- Integers, Constants
    base0A = "#c2c5dd", -- Classes, Search Background
    base0B = "#b8c4ff", -- Strings, Diff Inserted
    base0C = "#e4bad9", -- Regex, Escape Chars
    base0D = "#b8c4ff", -- Functions, Methods
    base0E = "#c2c5dd", -- Keywords, Storage
    base0F = "#93000a", -- Deprecated, Embedded Tags
  })

  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  local c = {
    bg = "#131316",
    bg_container = "#1f1f23",
    bg_high = "#2a2a2d",
    fg = "#e4e1e6",
    fg_muted = "#c6c5d0",
    border = "#90909a",
    primary = "#b8c4ff",
    secondary = "#c2c5dd",
    tertiary = "#e4bad9",
    error = "#ffb4ab",
    match = "#b8c4ff",
  }

  -- ── mini.files ───────────────────────────────────────────────────────
  hl("MiniFilesNormal", { fg = c.fg, bg = c.bg_container })
  hl("MiniFilesBorder", { fg = c.bg_container, bg = c.bg_container })
  hl("MiniFilesTitle", { fg = c.primary, bg = c.bg_container, bold = true })
  hl("MiniFilesTitleFocused", { fg = c.primary, bg = c.bg_container, bold = true })
  hl("MiniFilesCursorLine", { bg = c.bg_high })
  hl("MiniFilesDirectory", { fg = c.secondary })
  hl("MiniFilesFile", { fg = c.fg })

  -- ── snacks picker ────────────────────────────────────────────────────
  hl("SnacksPickerNormal", { fg = c.fg, bg = c.bg_container })
  hl("SnacksPickerBorder", { fg = c.bg_container, bg = c.bg_container })
  hl("SnacksPickerTitle", { fg = c.primary, bg = c.bg_container, bold = true })
  hl("SnacksPickerFooter", { fg = c.fg_muted, bg = c.bg_container })
  hl("SnacksPickerMatch", { fg = c.match, bold = true })
  hl("SnacksPickerSelected", { fg = c.primary, bold = true })
  hl("SnacksPickerCursorLine", { bg = c.bg_high })
  hl("SnacksPickerPreviewNormal", { fg = c.fg, bg = c.bg })
  hl("SnacksPickerPreviewBorder", { fg = c.bg, bg = c.bg })
  hl("SnacksPickerPreviewTitle", { fg = c.secondary, bg = c.bg, bold = true })

  -- ── blink.cmp ────────────────────────────────────────────────────────
  hl("BlinkCmpMenu", { fg = c.fg, bg = c.bg_container })
  hl("BlinkCmpMenuBorder", { fg = c.bg_container, bg = c.bg_container })
  hl("BlinkCmpMenuSelection", { bg = c.bg_high })
  hl("BlinkCmpScrollBarThumb", { bg = c.border })
  hl("BlinkCmpScrollBarGutter", { bg = c.bg_container })
  hl("BlinkCmpLabel", { fg = c.fg })
  hl("BlinkCmpLabelMatch", { fg = c.match, bold = true })
  hl("BlinkCmpLabelDeprecated", { fg = c.fg_muted, strikethrough = true })
  hl("BlinkCmpLabelDescription", { fg = c.fg_muted })
  hl("BlinkCmpDoc", { fg = c.fg, bg = c.bg_container })
  hl("BlinkCmpDocBorder", { fg = c.bg_container, bg = c.bg_container })
  hl("BlinkCmpDocSeparator", { fg = c.border })
  hl("BlinkCmpDocCursorLine", { bg = c.bg_high })
  hl("BlinkCmpSignatureHelp", { fg = c.fg, bg = c.bg_container })
  hl("BlinkCmpSignatureHelpBorder", { fg = c.bg_container, bg = c.bg_container })
  hl("BlinkCmpSignatureHelpActiveParameter", { fg = c.primary, bold = true })
  -- kind icons
  hl("BlinkCmpKindText", { fg = c.fg_muted })
  hl("BlinkCmpKindMethod", { fg = c.primary })
  hl("BlinkCmpKindFunction", { fg = c.primary })
  hl("BlinkCmpKindConstructor", { fg = c.secondary })
  hl("BlinkCmpKindField", { fg = c.tertiary })
  hl("BlinkCmpKindVariable", { fg = c.tertiary })
  hl("BlinkCmpKindClass", { fg = c.secondary })
  hl("BlinkCmpKindInterface", { fg = c.secondary })
  hl("BlinkCmpKindModule", { fg = c.secondary })
  hl("BlinkCmpKindProperty", { fg = c.tertiary })
  hl("BlinkCmpKindUnit", { fg = c.fg_muted })
  hl("BlinkCmpKindValue", { fg = c.tertiary })
  hl("BlinkCmpKindEnum", { fg = c.secondary })
  hl("BlinkCmpKindKeyword", { fg = c.match })
  hl("BlinkCmpKindSnippet", { fg = c.tertiary })
  hl("BlinkCmpKindColor", { fg = c.primary })
  hl("BlinkCmpKindFile", { fg = c.fg })
  hl("BlinkCmpKindReference", { fg = c.primary })
  hl("BlinkCmpKindFolder", { fg = c.secondary })
  hl("BlinkCmpKindEnumMember", { fg = c.tertiary })
  hl("BlinkCmpKindConstant", { fg = c.tertiary })
  hl("BlinkCmpKindStruct", { fg = c.secondary })
  hl("BlinkCmpKindEvent", { fg = c.error })
  hl("BlinkCmpKindOperator", { fg = c.fg_muted })
  hl("BlinkCmpKindTypeParameter", { fg = c.secondary })

  -- ── noice.nvim ───────────────────────────────────────────────────────
  hl("NoiceCmdline", { fg = c.fg, bg = c.bg_container })
  hl("NoiceCmdlineIcon", { fg = c.primary })
  hl("NoiceCmdlineIconSearch", { fg = c.match })
  hl("NoiceCmdlinePopup", { fg = c.fg, bg = c.bg_container })
  hl("NoiceCmdlinePopupBorder", { fg = c.border, bg = c.bg_container })
  hl("NoiceCmdlinePopupBorderSearch", { fg = c.match, bg = c.bg_container })
  hl("NoiceCmdlinePopupTitle", { fg = c.primary, bg = c.bg_container, bold = true })
  hl("NoiceConfirm", { fg = c.fg, bg = c.bg_container })
  hl("NoiceConfirmBorder", { fg = c.primary, bg = c.bg_container })
  hl("NoicePopup", { fg = c.fg, bg = c.bg_container })
  hl("NoicePopupBorder", { fg = c.border, bg = c.bg_container })
  hl("NoiceMini", { fg = c.fg_muted, bg = c.bg_container })
  hl("NoiceFormatProgressDone", { fg = c.primary, bg = c.bg_high, bold = true })
  hl("NoiceFormatProgressTodo", { fg = c.border, bg = c.bg_container })
  hl("NoiceLspProgressTitle", { fg = c.fg_muted })
  hl("NoiceLspProgressClient", { fg = c.primary })
  hl("NoiceVirtualText", { fg = c.fg_muted })
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    package.loaded["matugen"] = nil
    require("matugen").setup()
  end)
)

return M
