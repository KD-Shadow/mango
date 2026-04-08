local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#0c1017", -- Default Background
    base01 = "#11151d", -- Lighter Background (status bars)
    base02 = "#191e2a", -- Selection Background
    base03 = "#45a0d6", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#9b6bc1", -- Dark Foreground (status bars)
    base05 = "#5c8ac4", -- Default Foreground
    base06 = "#5c8ac4", -- Light Foreground
    base07 = "#5c8ac4", -- Lightest Foreground
    -- Accent colors
    base08 = "#b32d2d", -- Variables, XML Tags, Errors
    base09 = "#00a66c", -- Integers, Constants
    base0A = "#d14358", -- Classes, Search Background
    base0B = "#c4a82e", -- Strings, Diff Inserted
    base0C = "#80ffd2", -- Regex, Escape Chars
    base0D = "#e9d996", -- Functions, Methods
    base0E = "#e996a2", -- Keywords, Storage
    base0F = "#430a0a", -- Deprecated, Embedded Tags
  })

  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  local c = {
    bg = "#0c1017",
    bg_container = "#11151d",
    bg_high = "#191e2a",
    fg = "#5c8ac4",
    fg_muted = "#9b6bc1",
    border = "#45a0d6",
    primary = "#c4a82e",
    secondary = "#d14358",
    tertiary = "#00a66c",
    error = "#b32d2d",
    match = "#e9d996",
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
